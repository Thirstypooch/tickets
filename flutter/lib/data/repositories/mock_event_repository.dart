import '../datasources/mock_events.dart';
import '../models/event.dart';
import '../models/event_filter.dart';
import 'event_repository.dart';

class MockEventRepository implements EventRepository {
  @override
  Future<PaginatedEvents> getEvents(EventFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var events = MockEvents.listing;

    // Apply client-side filtering for mock
    if (filter.keyword.isNotEmpty) {
      final kw = filter.keyword.toLowerCase();
      events = events
          .where((e) =>
              e.name.toLowerCase().contains(kw) ||
              e.venueName.toLowerCase().contains(kw) ||
              e.city.toLowerCase().contains(kw))
          .toList();
    }
    if (filter.category.isNotEmpty) {
      events = events.where((e) => e.category == filter.category).toList();
    }
    if (filter.city.isNotEmpty) {
      events = events
          .where((e) => e.city.toLowerCase().contains(filter.city.toLowerCase()))
          .toList();
    }

    return PaginatedEvents(
      events: events,
      total: events.length,
      page: 0,
      pages: 1,
    );
  }

  @override
  Future<List<EventSummary>> getFeaturedEvents() async {
    return MockEvents.featured;
  }

  @override
  Future<EventDetail> getEventById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockEvents.detail;
  }
}
