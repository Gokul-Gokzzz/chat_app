import 'dart:async';

import 'package:auth/view/auth_screen.dart';
import 'package:flutter/material.dart';

class SplascScreen extends StatefulWidget {
  const SplascScreen({super.key});

  @override
  State<SplascScreen> createState() => _SplascScreenState();
}

class _SplascScreenState extends State<SplascScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Image.asset(
            "assets/splash.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
