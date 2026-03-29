class Guest {
  final String name;
  final String email;
  final String avatar;

  const Guest({
    required this.name,
    required this.email,
    required this.avatar,
  });
}

class Booking {
  final String id;
  final Guest guest;
  final String property;
  final String checkIn;
  final String checkOut;
  final int guests;
  final int total;
  final String status; // 'confirmed' | 'pending' | 'completed'

  const Booking({
    required this.id,
    required this.guest,
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.total,
    required this.status,
  });
}
