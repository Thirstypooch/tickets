import '../models/booking.dart';

class MockBookings {
  MockBookings._();

  static const all = [
    Booking(
      id: '1',
      guest: Guest(
        name: 'John Smith',
        email: 'john@example.com',
        avatar: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&fit=crop',
      ),
      property: 'Modern Loft in Downtown',
      checkIn: '2024-02-15',
      checkOut: '2024-02-18',
      guests: 2,
      total: 750,
      status: 'confirmed',
    ),
    Booking(
      id: '2',
      guest: Guest(
        name: 'Sarah Johnson',
        email: 'sarah@example.com',
        avatar: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&fit=crop',
      ),
      property: 'Beach House in Malibu',
      checkIn: '2024-03-10',
      checkOut: '2024-03-15',
      guests: 4,
      total: 2000,
      status: 'pending',
    ),
    Booking(
      id: '3',
      guest: Guest(
        name: 'Mike Chen',
        email: 'mike@example.com',
        avatar: 'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&fit=crop',
      ),
      property: 'Modern Loft in Downtown',
      checkIn: '2024-01-20',
      checkOut: '2024-01-25',
      guests: 3,
      total: 1250,
      status: 'completed',
    ),
  ];
}
