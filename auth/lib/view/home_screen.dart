import 'package:auth/controller/home_provider.dart';
import 'package:auth/view/post.dart';
import 'package:auth/widgets/drawer.dart';
import 'package:auth/widgets/helper/helper.dart';
import 'package:auth/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSccreen extends StatelessWidget {
  const HomeSccreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Consumer<HomeProvider>(
        builder: (context, value, child) => MyDrawer(
          onProfileTap: () => value.goToProfilePage(context),
          onSignOut: provider.signOut,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('User posts')
                    .orderBy('Timestamb', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //get the message
                        final post = snapshot.data!.docs[index];
                        return UserPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          time: formDate(post['Timestamb']),
                          likes: List<String>.from(post['Likes'] ?? []),
                        );
                      },
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: value.textController,
                      hintText: 'Write something here',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                      onPressed: value.postMessage,
                      icon: const Icon(Icons.arrow_circle_up)),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Logged in as : ${value.currentUser.email!}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 42, 154, 46)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
