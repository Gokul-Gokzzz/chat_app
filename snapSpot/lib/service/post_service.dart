import 'dart:developer';

import 'package:auth/model/post_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  String bookMarks = 'User posts';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  late CollectionReference<UserPostModel> bookmark;
  PostService() {
    bookmark = firestore.collection(bookMarks).withConverter<UserPostModel>(
        fromFirestore: (snapshot, options) {
      return UserPostModel.fromFirestore(snapshot);
    }, toFirestore: (value, options) {
      return value.toJson();
    });
  }

  // Stream of user posts
  Stream<List<UserPostModel>> fetchUserPosts() {
    return firestore
        .collection('User posts')
        .orderBy('Timestamb', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserPostModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> toggleLike(String postId, bool isLiked) async {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(postId);
    if (isLiked) {
      await postRef.update({
        'Likes':
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email])
      });
    } else {
      await postRef.update({
        'Likes':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.email]),
      });
    }
  }

  Future<void> addComment(String postId, String commentText) async {
    await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now()
    });
  }

  Future<int> fetchCommentCount(String postId) async {
    final snapshot = await firestore
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .get();
    return snapshot.docs.length;
  }

  Future<void> deletePost(String postId) async {
    //delete comment
    final commentDocs = await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .get();
    for (var doc in commentDocs.docs) {
      await doc.reference.delete();
    }
    //delete post
    await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .delete();
  }

  Future<void> wishlistClicked(String id, bool status) async {
    try {
      if (status == true) {
        await FirebaseFirestore.instance
            .collection('User posts')
            .doc(id)
            .update({
          'wishlist': FieldValue.arrayUnion(
              [currentUser.email ?? currentUser.phoneNumber])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('User posts')
            .doc(id)
            .update({
          'wishlist': FieldValue.arrayRemove(
              [currentUser.email ?? currentUser.phoneNumber])
        });
      }
    } catch (e) {
      log('got a error :$e');
    }
  }

  Future<List<UserPostModel>> getAllPost() async {
    final snapshot = await bookmark.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
