import '../datasources/mock_trips.dart';
import '../models/trip.dart';
import 'trip_repository.dart';

class MockTripRepository implements TripRepository {
  @override
  Future<List<Trip>> getUpcomingTrips() async {
    return MockTrips.upcoming;
  }

  @override
  Future<List<Trip>> getPastTrips() async {
    return MockTrips.past;
  }
}
