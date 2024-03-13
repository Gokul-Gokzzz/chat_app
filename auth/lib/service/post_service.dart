import 'package:auth/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> toggleLike(Post post) async {
    final isLiked = post.likes.contains(currentUser.email);

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(post.postId);

    if (isLiked) {
      await postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    } else {
      await postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    }
  }

  Future<void> addComment(String postId, String commentText) async {
    await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
    });
  }

  Stream<List<Post>> getPostsStream() {
    return FirebaseFirestore.instance
        .collection('User posts')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Post(
                postId: doc.id,
                message: data['message'],
                user: data['user'],
                likes: List<String>.from(data['likes'] ?? []),
                time: data['time'],
              );
            }).toList());
  }
}
