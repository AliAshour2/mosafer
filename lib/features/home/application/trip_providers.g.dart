// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tripRepositoryHash() => r'8a7833a151b9ac732dc3114970cf6c393077bc3e';

/// See also [tripRepository].
@ProviderFor(tripRepository)
final tripRepositoryProvider = AutoDisposeProvider<TripRepository>.internal(
  tripRepository,
  name: r'tripRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tripRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TripRepositoryRef = AutoDisposeProviderRef<TripRepository>;
String _$upcomingTripsHash() => r'273ead78fe7055cca94d2a96730f2e7d4e293a1e';

/// See also [upcomingTrips].
@ProviderFor(upcomingTrips)
final upcomingTripsProvider = AutoDisposeFutureProvider<List<Trip>>.internal(
  upcomingTrips,
  name: r'upcomingTripsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingTripsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingTripsRef = AutoDisposeFutureProviderRef<List<Trip>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
