import 'package:cloud_firestore/cloud_firestore.dart';

class UserPostModel {
  final String id;
  final String userEmail;
  final String message;
  final List<String> likes;
  final Timestamp postTime;
  bool isBookmarked;

  UserPostModel({
    required this.id,
    required this.userEmail,
    required this.message,
    required this.likes,
    required this.postTime,
    required this.isBookmarked,
  });

  factory UserPostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserPostModel(
      id: doc.id,
      userEmail: data['UserEmail'] ?? '',
      message: data['Message'] ?? '',
      likes: List.from(data['Likes'] ?? []),
      postTime: data['Timestamb'] ?? Timestamp.now(),
      isBookmarked: data['IsBookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'UserEmail': userEmail,
      'Message': message,
      'Likes': likes,
      'Timestamb': postTime,
    };
  }
}
