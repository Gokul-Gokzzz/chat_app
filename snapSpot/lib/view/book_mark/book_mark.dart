import 'package:auth/controller/post_provider.dart';
import 'package:auth/view/post/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Posts'),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser == null) {
            return Center(child: Text('User not logged in.'));
          }
          final user = currentUser.email ?? currentUser.phoneNumber;

          final wishlitItems = postProvider.allPost
              .where((post) => post.wishlist.contains(user))
              .toList();

          return ListView.builder(
            itemCount: wishlitItems.length,
            itemBuilder: (context, index) {
              final post = wishlitItems[index];
              return UserPost(
                message: post.message,
                user: post.userEmail,
                postId: post.id,
                likes: post.likes,
                postTime: post.postTime,
                save: post,
              );
            },
          );
        },
      ),
    );
  }
}
