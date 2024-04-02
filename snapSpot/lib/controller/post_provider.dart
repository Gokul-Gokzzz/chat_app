import 'package:auth/model/post_model.dart';
import 'package:auth/service/post_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostProvider extends ChangeNotifier {
  final TextEditingController commentTextController = TextEditingController();
  final PostService postService = PostService();
  List<UserPostModel> allPost = [];

  final currentUser = FirebaseAuth.instance.currentUser;

  bool isLiked = false;
  int commentCount = 0;
  bool isFavorite = false;

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

  void toggleLike(String postId, bool isLiked) async {
    await postService.toggleLike(postId, isLiked);
    // isLiked = !isCurrentlyLiked;
    notifyListeners();
  }

  Future<void> addComment(String postId, String commentText) async {
    await postService.addComment(postId, commentText);
    await fetchCommentCount(postId);
    notifyListeners();
  }

  Future<void> fetchCommentCount(String postId) async {
    commentCount = await postService.fetchCommentCount(postId);

    notifyListeners();
  }

  Future<void> deletePost(String postId) async {
    await postService.deletePost(postId);
    notifyListeners();
  }

  Future<void> wishlistClicked(String id, bool status) async {
    await postService.wishlistClicked(id, status);
    notifyListeners();
  }

  bool wishlistCheck(UserPostModel save) {
    if (currentUser != null) {
      final user = currentUser!.email ?? currentUser!.phoneNumber;
      if (save.wishlist.contains(user)) {
        getAllPost();
        return false;
      } else {
        getAllPost();
        return true;
      }
    } else {
      return true;
    }
  }

  getAllPost() async {
    allPost = await postService.getAllPost();
    notifyListeners();
  }
}
