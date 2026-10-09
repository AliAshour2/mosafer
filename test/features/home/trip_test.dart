import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/features/home/domain/entities/trip.dart';

void main() {
  test('parses trip data from Supabase rows', () {
    final trip = Trip.fromMap({
      'id': 'trip-1',
      'origin': 'Alexandria',
      'destination': 'Cairo',
      'departure_at': '2026-10-12T14:41:00Z',
      'price': '250.00',
      'currency': 'EGP',
      'seats_available': 5,
    });

    expect(trip.id, 'trip-1');
    expect(trip.origin, 'Alexandria');
    expect(trip.destination, 'Cairo');
    expect(trip.departureAt, DateTime.utc(2026, 10, 12, 14, 41));
    expect(trip.price, 250);
    expect(trip.currency, 'EGP');
    expect(trip.seatsAvailable, 5);
  });

  test('rejects malformed trip rows', () {
    expect(
      () => Trip.fromMap({
        'id': 'trip-1',
        'origin': 'Alexandria',
        'destination': 'Cairo',
        'departure_at': 'not-a-date',
        'price': 'not-a-price',
        'currency': 'EGP',
        'seats_available': 5,
      }),
      throwsFormatException,
    );
  });
}
