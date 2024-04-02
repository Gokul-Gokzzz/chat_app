import 'package:auth/model/post_model.dart';
import 'package:auth/widgets/comment.dart';
import 'package:auth/widgets/delete_buttom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/controller/post_provider.dart';
import 'package:auth/widgets/comment_button.dart';
import 'package:auth/widgets/comment_dialog.dart';
import 'package:auth/widgets/delete_dialog.dart';
import 'package:auth/widgets/like_button.dart';

class UserPost extends StatelessWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  final Timestamp postTime;
  final UserPostModel save;

  UserPost({
    Key? key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.postTime,
    required this.save,
  }) : super(key: key);

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // final scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 194, 209, 194),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<PostProvider>(
                            builder: (context, value, child) => IconButton(
                                onPressed: () {
                                  final wish = value.wishlistCheck(save);
                                  value.wishlistClicked(save.id, wish);
                                  print('object');
                                  // scaffoldKey.currentState?.showSnakbar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //           wish
                                  //             ? 'Added to bookmark'
                                  //             : 'Removed from bookmark')));
                                },
                                icon: value.wishlistCheck(save)
                                    ? Icon(
                                        Icons.bookmark_outline,
                                        color: Colors.blue,
                                      )
                                    : Icon(Icons.bookmark)))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          //comment box
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User posts')
                .doc(postId)
                .collection('Comments')
                .orderBy('CommentTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Widget> commentWidgets = snapshot.data!.docs.map((doc) {
                final commentData = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CommentScreen(
                    text: commentData['CommentText'],
                    user: commentData['CommentedBy'],
                    time: Provider.of<PostProvider>(context, listen: false)
                        .formatDate(commentData['CommentTime']),
                  ),
                );
              }).toList();
              return Column(
                children: commentWidgets,
              );
            },
          ),
          // like, comment, delete icon and count
          const SizedBox(height: 20),
          Consumer<PostProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LikeButton(
                  isLiked: value.isLiked,
                  onTap: () => value.toggleLike(postId, value.isLiked),
                ),
                Text(
                  '${likes.length} likes',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 30),
                CommentButton(
                  onTap: () => showCommentDialog(context, postId),
                ),
                Text(
                  '${value.commentCount} comments',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 20),
                if (user == currentUser.email)
                  DeleteButton(
                    onTap: () => deleteDialogue(context, postId),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
