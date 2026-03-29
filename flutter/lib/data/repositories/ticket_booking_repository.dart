import '../models/ticket_booking.dart';

abstract class TicketBookingRepository {
  Future<List<TicketBooking>> getUpcoming();
  Future<List<TicketBooking>> getPast();
  Future<List<TicketBooking>> getAll();
  Future<TicketBooking> createBooking({
    required String tmEventId,
    required int quantity,
    required double unitPrice,
  });
}
