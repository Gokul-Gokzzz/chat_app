import 'package:auth/controller/home_provider.dart';
import 'package:auth/controller/login_provider.dart';
import 'package:auth/controller/post_provider.dart';
import 'package:auth/controller/profile_provider.dart';
import 'package:auth/controller/reg_provider.dart';
import 'package:auth/firebase_options.dart';
import 'package:auth/view/auth_screen.dart';
import 'package:auth/widgets/themes/dark_theme.dart';
import 'package:auth/widgets/themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        // ChangeNotifierProvider(create: (context) => BottomBarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const AuthPage(),
      ),
    );
  }
}
