import '../models/trip.dart';

abstract class TripRepository {
  Future<List<Trip>> getUpcomingTrips();
  Future<List<Trip>> getPastTrips();
}
