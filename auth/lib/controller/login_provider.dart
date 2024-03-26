// ignore_for_file: use_build_context_synchronously

import 'package:auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService();

  void signInWithEmailAndPassword(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await _authenticationService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      if (context.mounted) Navigator.pop(context);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code, context);
      notifyListeners();
    }
  }

  void signInWithGithub(context) async {
    try {
      await _authenticationService.signInWithGithub(context);
      notifyListeners();
    } catch (e) {
      displayMessage(e.toString(), context);
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle(context) async {
    try {
      await _authenticationService.signInWithGoogle();
      notifyListeners();
    } catch (e) {
      displayMessage(e.toString(), context);
      notifyListeners();
    }
  }

  void displayMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }
}
