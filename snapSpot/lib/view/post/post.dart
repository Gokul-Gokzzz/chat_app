import 'package:auth/widgets/comment.dart';
import 'package:auth/widgets/comment_button.dart';
import 'package:auth/widgets/comment_dialog.dart';
import 'package:auth/widgets/delete_buttom.dart';
import 'package:auth/widgets/delete_dialog.dart';
import 'package:auth/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/controller/post_provider.dart';

class UserPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  final Timestamp postTime;
  final bool isBookmarked;

  const UserPost({
    Key? key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.postTime,
    required this.isBookmarked,
  }) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
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
                      widget.user,
                      style: const TextStyle(
                          // color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.message,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            final postProvider = Provider.of<PostProvider>(
                                context,
                                listen: false);
                            postProvider.toggleBookmark(
                                widget.postId, !widget.isBookmarked);
                          },
                          icon: Icon(
                            widget.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: widget.isBookmarked ? Colors.blue : null,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User posts')
                .doc(widget.postId)
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
          const SizedBox(height: 20),
          Consumer<PostProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LikeButton(
                  isLiked: value.isLiked,
                  onTap: () => value.toggleLike(widget.postId, value.isLiked),
                ),
                Text(
                  '${widget.likes.length} likes',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 30),
                CommentButton(
                  onTap: () => showCommentDialog(context, widget.postId),
                ),
                Text(
                  '${value.commentCount} comments',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 20),
                if (widget.user == currentUser.email)
                  DeleteButton(
                      onTap: () => deleteDialogue(context, widget.postId)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
