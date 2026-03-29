import 'package:dio/dio.dart';
import '../../core/api/api_client.dart';
import '../models/ticket_booking.dart';
import 'ticket_booking_repository.dart';

/// Calls NestJS REST endpoints for booking data.
class ApiBookingRepository implements TicketBookingRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<List<TicketBooking>> getUpcoming() async {
    final response = await _dio.get('/bookings/upcoming');
    return (response.data as List)
        .map((b) => TicketBooking.fromJson(b))
        .toList();
  }

  @override
  Future<List<TicketBooking>> getPast() async {
    final response = await _dio.get('/bookings/past');
    return (response.data as List)
        .map((b) => TicketBooking.fromJson(b))
        .toList();
  }

  @override
  Future<List<TicketBooking>> getAll() async {
    final response = await _dio.get('/bookings');
    return (response.data as List)
        .map((b) => TicketBooking.fromJson(b))
        .toList();
  }

  @override
  Future<TicketBooking> createBooking({
    required String tmEventId,
    required int quantity,
    required double unitPrice,
  }) async {
    final response = await _dio.post('/bookings', data: {
      'tmEventId': tmEventId,
      'quantity': quantity,
      'unitPrice': unitPrice,
    });
    return TicketBooking.fromJson(response.data);
  }
}
