import 'package:flutter/material.dart';
import 'package:auth/model/post_model.dart';

class Bookmarks extends StatelessWidget {
  final List<UserPostModel> bookmarkedPosts;

  const Bookmarks({super.key, required this.bookmarkedPosts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Posts'),
      ),
      body: ListView.builder(
        itemCount: bookmarkedPosts.length,
        itemBuilder: (context, index) {
          final post = bookmarkedPosts[index];
          return ListTile(
            title: Text(post.message),
            subtitle: Text(post.userEmail),
          );
        },
      ),
    );
  }
}
