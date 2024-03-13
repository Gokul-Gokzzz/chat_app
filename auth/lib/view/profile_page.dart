// ignore_for_file: use_build_context_synchronously
import 'package:auth/controller/profile_provider.dart';
import 'package:auth/widgets/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) => StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(value.currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get the user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  //profile pic
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 226, 220, 220),
                      radius: 50,
                      child: Image.asset(
                        'assets/user.png',
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //user email
                  Text(
                    value.currentUser.email!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  //user details
                  const Text(
                    'My details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  //username
                  MyTextBox(
                    text: userData['username'],
                    sectionName: 'Username',
                    onPressed: () => value.editFields(
                        'username', context), // changed to lowercase
                  ),
                  //bio
                  const SizedBox(height: 20),
                  MyTextBox(
                    text: userData['bio'],
                    sectionName: ' Bio',
                    onPressed: () => value.editFields(
                        'bio', context), // changed to lowercase
                  ),
                  //user posts
                  const SizedBox(height: 20),
                  const Text(
                    'My post',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error:${snapshot.error}'));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
