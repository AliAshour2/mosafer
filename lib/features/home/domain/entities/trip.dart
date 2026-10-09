class Trip {
  const Trip({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departureAt,
    required this.price,
    required this.currency,
    required this.seatsAvailable,
  });

  final String id;
  final String origin;
  final String destination;
  final DateTime departureAt;
  final double price;
  final String currency;
  final int seatsAvailable;

  factory Trip.fromMap(Map<String, dynamic> row) {
    final id = row['id'];
    final origin = row['origin'];
    final destination = row['destination'];
    final departureAt = row['departure_at'];
    final price = row['price'];
    final currency = row['currency'];
    final seatsAvailable = row['seats_available'];

    if (id is! String ||
        origin is! String ||
        destination is! String ||
        departureAt is! String ||
        currency is! String ||
        seatsAvailable is! int) {
      throw const FormatException('Trip data has an invalid field.');
    }

    final parsedDeparture = DateTime.tryParse(departureAt);
    final parsedPrice = switch (price) {
      num value => value.toDouble(),
      String value => double.tryParse(value),
      _ => null,
    };
    if (parsedDeparture == null || parsedPrice == null) {
      throw const FormatException('Trip data has an invalid date or price.');
    }

    return Trip(
      id: id,
      origin: origin,
      destination: destination,
      departureAt: parsedDeparture,
      price: parsedPrice,
      currency: currency,
      seatsAvailable: seatsAvailable,
    );
  }
}
