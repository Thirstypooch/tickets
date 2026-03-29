class ReviewUser {
  final String name;
  final String avatar;

  const ReviewUser({required this.name, required this.avatar});
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
}
