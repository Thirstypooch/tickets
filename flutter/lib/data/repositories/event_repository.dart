import '../models/event.dart';
import '../models/event_filter.dart';

/// Paginated response from the events endpoint.
class PaginatedEvents {
  final List<EventSummary> events;
  final int total;
  final int page;
  final int pages;

  const PaginatedEvents({
    required this.events,
    required this.total,
    required this.page,
    required this.pages,
  });

  factory PaginatedEvents.fromJson(Map<String, dynamic> json) {
    return PaginatedEvents(
      events: (json['events'] as List)
          .map((e) => EventSummary.fromJson(e))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      pages: json['pages'] as int,
    );
  }
}

abstract class EventRepository {
  Future<PaginatedEvents> getEvents(EventFilter filter);
  Future<List<EventSummary>> getFeaturedEvents();
  Future<EventDetail> getEventById(String id);
}
