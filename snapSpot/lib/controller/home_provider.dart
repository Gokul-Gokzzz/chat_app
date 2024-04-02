import 'package:auth/model/post_model.dart';
import 'package:auth/service/post_service.dart';
import 'package:auth/view/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final PostService _firestoreService = PostService();
  final TextEditingController textController = TextEditingController();
  String searchQuery = '';
  //sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  //post message
  postMessage() {
    //only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance.collection('User posts').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'Timestamb': Timestamp.now(),
        'Likes': [],
        'wishlist': [],
      });
      notifyListeners();
    }
    textController.clear();
  }

  Stream<List<UserPostModel>> get userPostModel =>
      _firestoreService.fetchUserPosts();

  void goToProfilePage(context) {
    Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
    notifyListeners();
  }
}
