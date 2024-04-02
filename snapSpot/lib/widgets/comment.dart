import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const CommentScreen({
    Key? key,
    required this.text,
    required this.user,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        // Positioned.fill(
        //   child: Image.asset(
        //     'assets/cmt.jpeg', // Provide your image path here
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // Comment Container
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  user,
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: [
                    // Text(
                    //   " • ",
                    //   style: TextStyle(color: Colors.grey[400]),
                    // ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
