import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:auth/controller/login_provider.dart';
import 'package:auth/view/phone_auth/phone_auth.dart';
import 'package:auth/view/register/reg_screen.dart';
import 'package:auth/widgets/button.dart';
import 'package:auth/widgets/square_button.dart';
import 'package:auth/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  final Function()? onTap;

  const LoginScreen({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/lg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Consumer<LoginProvider>(
                  builder: (context, value, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: value.emailController,
                        hintText: 'Enter the email',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: value.passwordController,
                        hintText: 'Enter the password here',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        text: 'Sign In',
                        onTap: () => value.signInWithEmailAndPassword(context),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have account? ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              onTap;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen()));
                            },
                            child: const Text(
                              'Register now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                          const Text(
                            "Or connect with",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareButton(
                              imagePath: 'assets/google.json',
                              onTap: () => value.signInWithGoogle(context),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SquareButton(
                                imagePath: 'assets/github.json',
                                onTap: () => value.signInWithGithub(context)),
                            const SizedBox(
                              width: 5,
                            ),
                            SquareButton(
                                imagePath: 'assets/phone.json',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PhoneAuth()));
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
