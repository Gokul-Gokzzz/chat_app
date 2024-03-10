import 'package:auth/firebase_options.dart';
import 'package:auth/view/auth_screen.dart';
import 'package:auth/widgets/themes/dark_theme.dart';
import 'package:auth/widgets/themes/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthScreen(),
    );
  }
}
