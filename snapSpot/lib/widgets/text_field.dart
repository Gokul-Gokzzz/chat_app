// my_text_field.dart
// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final bool? obscureText;
  final String? Function(dynamic value)? validator;

  final Widget? suffixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage('assets/image 3.png'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            helperStyle: TextStyle(color: Colors.grey[500]),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
