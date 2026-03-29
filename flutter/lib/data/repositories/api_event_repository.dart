import 'package:dio/dio.dart';
import '../../core/api/api_client.dart';
import '../models/event.dart';
import '../models/event_filter.dart';
import 'event_repository.dart';

/// Calls NestJS REST endpoints for event data.
class ApiEventRepository implements EventRepository {
  final Dio _dio = ApiClient.instance;

  @override
  Future<PaginatedEvents> getEvents(EventFilter filter) async {
    final response = await _dio.get(
      '/events',
      queryParameters: filter.toQueryParams(),
    );
    return PaginatedEvents.fromJson(response.data);
  }

  @override
  Future<List<EventSummary>> getFeaturedEvents() async {
    final response = await _dio.get('/events/featured');
    return (response.data as List)
        .map((e) => EventSummary.fromJson(e))
        .toList();
  }

  @override
  Future<EventDetail> getEventById(String id) async {
    final response = await _dio.get('/events/$id');
    return EventDetail.fromJson(response.data);
  }
}
