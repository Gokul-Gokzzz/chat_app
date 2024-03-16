// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void deleteDialogue(BuildContext context, String postId) {
  //show a dialog box asking for confirmation
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text(
        'Delete Post',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this post?',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            //delete the comment from fire store first
            final commentDocs = await FirebaseFirestore.instance
                .collection('User posts')
                .doc(postId) // Use the passed postId here
                .collection('Comments')
                .get();
            for (var doc in commentDocs.docs) {
              await FirebaseFirestore.instance
                  .collection('User posts')
                  .doc(postId)
                  .collection('Comments')
                  .doc(doc.id)
                  .delete();
            }
            //then delete the post
            FirebaseFirestore.instance
                .collection('User posts')
                .doc(postId)
                .delete()
                .then((value) => print('Delete the post'))
                .catchError((error) => print('failed to delete post'));

            //dismiss the dialog box
            Navigator.pop(context);
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        )
      ],
    ),
  );
}
