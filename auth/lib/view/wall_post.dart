import 'package:auth/widgets/comment_button.dart';
import 'package:auth/widgets/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toogleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Post').doc(widget.postId);
    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Post")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment "),
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(hintText: "Write a comment"),
        ),
        actions: [
          TextButton(
            onPressed: () => addComment(commentController.text),
            child: Text("Post"),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancell'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column(
          //   children: [
          //     LikeButton(
          //       isLiked: isLiked,
          //       onTap: toogleLike,
          //     ),
          //     SizedBox(
          //       height: 5,
          //     ),
          //     Text(
          //       widget.likes.length.toString(),
          //       style: TextStyle(color: Colors.grey),
          //     ),
          //   ],
          // ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[500]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.message),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toogleLike,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  CommentButton(onTap: showCommentDialog),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          )
          // Column(
          //   children: [
          //     LikeButton(
          //       isLiked: isLiked,
          //       onTap: toogleLike,
          //     ),
          //     SizedBox(
          //       height: 5,
          //     ),
          //     Text(
          //       widget.likes.length.toString(),
          //       style: TextStyle(color: Colors.grey),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
