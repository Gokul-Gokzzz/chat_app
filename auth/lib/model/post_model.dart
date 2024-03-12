class Post {
  final String postId;
  final String message;
  final String user;
  final List<String> likes;
  final String time;

  Post({
    required this.postId,
    required this.message,
    required this.user,
    required this.likes,
    required this.time,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      message: json['message'],
      user: json['user'],
      likes: List<String>.from(json['likes'] ?? []),
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'message': message,
      'user': user,
      'likes': likes,
      'time': time,
    };
  }
}
