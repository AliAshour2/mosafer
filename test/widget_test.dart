import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mosafer/features/home/presentation/screens/home_screen.dart';
import 'package:mosafer/features/home/presentation/widgets/travel_details_card.dart';
import 'package:mosafer/features/home/application/trip_providers.dart';
import 'package:mosafer/features/home/domain/entities/trip.dart';
import 'package:mosafer/l10n/app_localizations.dart';
import 'package:mosafer/theme/app_theme.dart';

void main() {
  testWidgets('home screen displays travel search and route sections',
      (tester) async {
    await tester.pumpWidget(_homeApp(() async => [_demoTrip()]));
    await tester.pumpAndSettle();

    expect(find.text('Where are you going?'), findsOneWidget);
    expect(find.text('Upcoming'), findsNWidgets(2));
    await tester.ensureVisible(find.text('Popular routes'));
    await tester.pumpAndSettle();
    expect(find.text('Popular routes'), findsOneWidget);
    expect(find.byType(TravelDetailsCard), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                TravelDetailsCard.imageAsset,
      ),
      findsOneWidget,
    );
  });

  testWidgets('home displays empty trip sections when no trips are available',
      (tester) async {
    await tester.pumpWidget(_homeApp(() async => []));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('No upcoming trips right now.'));
    await tester.pumpAndSettle();

    expect(find.text('No upcoming trips right now.'), findsOneWidget);
    expect(find.text('Popular routes will appear here.'), findsOneWidget);
  });

  testWidgets('home retries after a trip load failure', (tester) async {
    var requests = 0;
    await tester.pumpWidget(
      _homeApp(() async {
        requests++;
        if (requests == 1) {
          throw StateError('network unavailable');
        }
        return [_demoTrip()];
      }),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Trips are temporarily unavailable'), findsOneWidget);
    expect(find.textContaining('network unavailable'), findsNothing);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(TravelDetailsCard));
    await tester.pumpAndSettle();

    expect(requests, 2);
    expect(find.byType(TravelDetailsCard), findsOneWidget);
  });
}

Widget _homeApp(Future<List<Trip>> Function() fetchTrips) {
  return ProviderScope(
    overrides: [
      upcomingTripsProvider.overrideWith((ref) => fetchTrips()),
    ],
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeScreen(),
    ),
  );
}

Trip _demoTrip() {
  return Trip(
    id: 'demo-trip',
    origin: 'Alexandria',
    destination: 'Cairo',
    departureAt: DateTime.now().add(const Duration(days: 3)),
    price: 250,
    currency: 'EGP',
    seatsAvailable: 5,
  );
}
