import '../entities/trip.dart';

abstract interface class TripRepository {
  Future<List<Trip>> fetchUpcomingTrips();
}
