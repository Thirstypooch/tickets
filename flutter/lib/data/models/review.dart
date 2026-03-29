class ReviewUser {
  final String name;
  final String avatar;

  const ReviewUser({required this.name, required this.avatar});

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      name: json['name'] as String? ?? json['userName'] as String? ?? '',
      avatar: json['avatar'] as String? ?? json['userAvatar'] as String? ?? '',
    );
  }
}

class Review {
  final String id;
  final ReviewUser user;
  final int rating;
  final String date;
  final String comment;

  const Review({
    required this.id,
    required this.user,
    required this.rating,
    required this.date,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      user: json['user'] != null
          ? ReviewUser.fromJson(json['user'] as Map<String, dynamic>)
          : ReviewUser(
              name: json['userName'] as String? ?? '',
              avatar: json['userAvatar'] as String? ?? '',
            ),
      rating: json['rating'] as int,
      date: json['date'] as String? ?? json['createdAt'] as String? ?? '',
      comment: json['comment'] as String,
    );
  }
}
