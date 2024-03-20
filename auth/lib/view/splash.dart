// import 'dart:async';

// import 'package:auth/view/auth_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class SplascScreen extends StatefulWidget {
//   const SplascScreen({super.key});

//   @override
//   State<SplascScreen> createState() => _SplascScreenState();
// }

// class _SplascScreenState extends State<SplascScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => AuthPage()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Center(
//         child: Image.asset("assets/social-media.jpg", fit: BoxFit.cover),
//       ),
//     );
//   }
// }
