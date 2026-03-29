import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/trip.dart';
import '../../data/repositories/trip_repository.dart';
import '../../data/repositories/trip_repository_impl.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  return MockTripRepository();
});

final upcomingTripsProvider = FutureProvider<List<Trip>>((ref) {
  return ref.watch(tripRepositoryProvider).getUpcomingTrips();
});

final pastTripsProvider = FutureProvider<List<Trip>>((ref) {
  return ref.watch(tripRepositoryProvider).getPastTrips();
});
