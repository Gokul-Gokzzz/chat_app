import 'package:auth/service/post_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostProvider extends ChangeNotifier {
  final TextEditingController commentTextController = TextEditingController();
  final FirestoreService _postService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLiked = false;
  int commentCount = 0;

  String formatDate(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime postDateTime = timestamp.toDate();

    // Difference in seconds
    int difference = now.difference(postDateTime).inSeconds;

    if (difference < 60) {
      return 'Just now';
    } else if (difference < 3600) {
      int minutes = (difference / 60).floor();
      return '$minutes minutes ago';
    } else if (difference < 86400) {
      int hours = (difference / 3600).floor();
      return '$hours hours ago';
    } else {
      // Display the date
      return DateFormat('MMM dd, yyyy').format(postDateTime);
    }
  }

  void toggleLike(String postId, bool isCurrentlyLiked) async {
    await _postService.toggleLike(postId, !isCurrentlyLiked);
    notifyListeners();
  }

  Future<void> addComment(String postId, String commentText) async {
    await _postService.addComment(postId, commentText);
    await fetchCommentCount(postId);
    notifyListeners();
  }

  Future<void> fetchCommentCount(String postId) async {
    commentCount = await _postService.fetchCommentCount(postId);

    notifyListeners();
  }

  Future<void> deletePost(String postId) async {
    await _postService.deletePost(postId);
    notifyListeners();
  }

  Future<void> toggleBookmark(String postId, bool isBookmarked) async {
    try {
      await _firestore.collection('User posts').doc(postId).update({
        'IsBookmarked': isBookmarked,
      });
    } catch (e) {
      print('Error toggling bookmark: $e');
    }
    notifyListeners();
  }
}
