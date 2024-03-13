// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:auth/widgets/comment.dart';
import 'package:auth/widgets/comment_button.dart';
import 'package:auth/widgets/delete_buttom.dart';
import 'package:auth/widgets/helper/helper.dart';
import 'package:auth/widgets/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  final String time;

  const UserPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final TextEditingController commentTextController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  int commentCount = 0;

  @override
  void initState() {
    // final provider = Provider.of<PostProvider>(context, listen: false);
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    fetchCommentCount();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    //access the document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

    if (isLiked) {
      //if the post is now liked then add the users email to the 'likes field'
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if the post is now unliked, remove the users email  from the 'likes field'
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  //add comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
    }).then((value) => fetchCommentCount());
  }

  //update the comment count
  void fetchCommentCount() {
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .get()
        .then((snapshot) {
      setState(() {
        commentCount = snapshot.docs.length;
      });
    });
  }

  //show a dialogue box for adding comments
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add comment'),
        content: TextField(
          controller: commentTextController,
          decoration: const InputDecoration(hintText: 'Write a comment..'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                commentTextController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          TextButton(
            onPressed: () {
              addComment(commentTextController.text);
              commentTextController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Post',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  //delete post
  void deletePost() {
    //show a dialog box asking for confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              //delete the comment from fire store first
              //(if you only delete the post, the comments will still be the stored in firestore)
              final commentDocs = await FirebaseFirestore.instance
                  .collection('User posts')
                  .doc(widget.postId)
                  .collection('Comments')
                  .get();
              for (var doc in commentDocs.docs) {
                await FirebaseFirestore.instance
                    .collection('User posts')
                    .doc(widget.postId)
                    .collection('Comments')
                    .doc(doc.id)
                    .delete();
              }
              //then delete the post
              FirebaseFirestore.instance
                  .collection('User posts')
                  .doc(widget.postId)
                  .delete()
                  .then((value) => print('Delete the post'))
                  .catchError((error) => print('failed to delete post'));

              //dismiss the dialog box
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.time,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.message,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //comment under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User posts')
                .doc(widget.postId)
                .collection('Comments')
                .orderBy('CommentTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              //show loading circle if no data yet
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Widget> commentWidgets = snapshot.data!.docs.map((doc) {
                //get the comment
                final commentData = doc.data() as Map<String, dynamic>;
                //return the comment
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CommentScreen(
                    text: commentData['CommentText'],
                    user: commentData['CommentedBy'],
                    time: formDate(commentData['CommentTime']),
                  ),
                );
              }).toList();
              return Column(
                children: commentWidgets,
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              Text(
                '${widget.likes.length} likes',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(width: 30),
              CommentButton(
                onTap: showCommentDialog,
              ),
              Text(
                '$commentCount comments',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(width: 20),
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost),
            ],
          ),
        ],
      ),
    );
  }
}
