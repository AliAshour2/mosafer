import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';

class SupabaseTripRepository implements TripRepository {
  const SupabaseTripRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Trip>> fetchUpcomingTrips() async {
    final rows = await _client
        .from('trips')
        .select(
          'id, origin, destination, departure_at, price, currency, seats_available',
        )
        .eq('is_demo', true)
        .eq('status', 'scheduled')
        .gte('departure_at', DateTime.now().toUtc().toIso8601String())
        .order('departure_at')
        .limit(10);

    return rows.map((row) => Trip.fromMap(row)).toList(growable: false);
  }
}
