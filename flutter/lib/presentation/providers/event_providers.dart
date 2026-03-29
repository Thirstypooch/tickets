import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/event.dart';
import '../../data/models/event_filter.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/repositories/api_event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return ApiEventRepository();
});

final eventFilterProvider = StateProvider<EventFilter>((ref) {
  return const EventFilter();
});

final eventsProvider = FutureProvider<PaginatedEvents>((ref) {
  final filter = ref.watch(eventFilterProvider);
  return ref.watch(eventRepositoryProvider).getEvents(filter);
});

final featuredEventsProvider = FutureProvider<List<EventSummary>>((ref) {
  return ref.watch(eventRepositoryProvider).getFeaturedEvents();
});

final eventDetailProvider =
    FutureProvider.family<EventDetail, String>((ref, id) {
  return ref.watch(eventRepositoryProvider).getEventById(id);
});
