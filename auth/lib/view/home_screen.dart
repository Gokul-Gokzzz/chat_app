import 'package:auth/controller/home_provider.dart';
import 'package:auth/model/post_model.dart';
import 'package:auth/view/post.dart';
import 'package:auth/widgets/drawer.dart';
import 'package:auth/widgets/text_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         colors: [
            //       Color.fromARGB(255, 212, 178, 191),
            //       Color.fromARGB(255, 116, 39, 69),
            //     ])),
            ),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      drawer: Consumer<HomeProvider>(
        builder: (context, value, child) => MyDrawer(
          onProfileTap: () => value.goToProfilePage(context),
          onSignOut: provider.signOut,
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/image1.jfif'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Consumer<HomeProvider>(
            builder: (context, value, child) => Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: Provider.of<HomeProvider>(context, listen: false)
                          .userPostModel,
                      builder: (context,
                          AsyncSnapshot<List<UserPostModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data![index];
                              return UserPost(
                                message: post.message,
                                user: post.userEmail,
                                postId: post.id,
                                likes: post.likes,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error ${snapshot.error}'));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
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
                // Text(
                //   'Logged in as : ${value.currentUser.email!}',
                //   style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: Color.fromARGB(255, 42, 154, 46)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
