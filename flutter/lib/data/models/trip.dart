class TripProperty {
  final String title;
  final String location;
  final String image;

  const TripProperty({
    required this.title,
    required this.location,
    required this.image,
  });
}

class Trip {
  final String id;
  final TripProperty property;
  final String checkIn;
  final String checkOut;
  final int guests;
  final int total;
  final String status; // 'confirmed' | 'completed' | 'pending'
  final int? rating;

  const Trip({
    required this.id,
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.total,
    required this.status,
    this.rating,
  });
}
