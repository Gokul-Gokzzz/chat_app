// import 'package:auth/view/login.dart';
// import 'package:auth/view/reg_screen.dart';
// import 'package:flutter/material.dart';

// class LoginOrRegisterScreen extends StatefulWidget {
//   const LoginOrRegisterScreen({super.key});

//   @override
//   State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();


// class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
//   bool showLoginPage = true;

//   void tooglePage() {
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage) {
//       return LoginScreen(
//         onTap: tooglePage,
//       );
//     } else {
//       return RegisterScreen(
//         onTap: tooglePage,
//       );
//     }
//   }
// }
