import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/supabase_client_provider.dart';
import '../data/repositories/supabase_trip_repository.dart';
import '../domain/entities/trip.dart';
import '../domain/repositories/trip_repository.dart';

part 'trip_providers.g.dart';

@riverpod
TripRepository tripRepository(Ref ref) {
  return SupabaseTripRepository(ref.watch(supabaseClientProvider));
}

@riverpod
Future<List<Trip>> upcomingTrips(Ref ref) {
  return ref.watch(tripRepositoryProvider).fetchUpcomingTrips();
}
