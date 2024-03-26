import 'package:auth/controller/home_provider.dart';
import 'package:auth/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            homeProvider.searchQuery = value;
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream:
              Provider.of<HomeProvider>(context, listen: false).userPostModel,
          builder: (context, AsyncSnapshot<List<UserPostModel>> snapshot) {
            if (snapshot.hasData) {
              final List<UserPostModel> filteredPosts = snapshot.data!
                  .where((post) => post.userEmail
                      .toLowerCase()
                      .contains(homeProvider.searchQuery.toLowerCase()))
                  .toList();
              return ListView.builder(
                itemCount: filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = filteredPosts[index];
                  return ListTile(
                    title: Text(post.message),
                    subtitle: Text(post.userEmail),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
