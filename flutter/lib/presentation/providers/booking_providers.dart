import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/ticket_booking.dart';
import '../../data/repositories/ticket_booking_repository.dart';
import '../../data/repositories/mock_booking_repository.dart';
// import '../../data/repositories/api_booking_repository.dart';

final bookingRepositoryProvider = Provider<TicketBookingRepository>((ref) {
  return MockBookingRepository();
  // return ApiBookingRepository();
});

final upcomingBookingsProvider = FutureProvider<List<TicketBooking>>((ref) {
  return ref.watch(bookingRepositoryProvider).getUpcoming();
});

final pastBookingsProvider = FutureProvider<List<TicketBooking>>((ref) {
  return ref.watch(bookingRepositoryProvider).getPast();
});

final allBookingsProvider = FutureProvider<List<TicketBooking>>((ref) {
  return ref.watch(bookingRepositoryProvider).getAll();
});
