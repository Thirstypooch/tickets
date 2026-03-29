import '../datasources/mock_bookings.dart';
import '../models/booking.dart';
import 'booking_repository.dart';

class MockBookingRepository implements BookingRepository {
  @override
  Future<List<Booking>> getBookings() async {
    return MockBookings.all;
  }
}
