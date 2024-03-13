import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const CommentScreen({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      // padding: EdgeInsets.all(15),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(text),
            Text(
              user,
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text(
              " . ",
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text(
              time,
              style: TextStyle(color: Colors.grey[400]),
            )
          ],
        ),
      ),
    );
  }
}
