import 'package:auth/controller/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCommentDialog(BuildContext context, String postId) {
  // Accept postId as a parameter
  final provider = Provider.of<PostProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add comment'),
      content: TextField(
        controller: provider.commentTextController,
        decoration: const InputDecoration(hintText: 'Write a comment..'),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              provider.commentTextController.clear();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        TextButton(
          onPressed: () {
            provider.addComment(postId, provider.commentTextController.text);
            provider.commentTextController.clear();
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
