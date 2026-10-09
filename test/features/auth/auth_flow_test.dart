import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/app/app.dart';
import 'package:mosafer/core/design_system/components/buttons/app_button.dart';
import 'package:mosafer/features/auth/application/auth_providers.dart';
import 'package:mosafer/features/auth/data/repositories/demo_auth_repository.dart';
import 'package:mosafer/features/auth/domain/entities/auth_failure.dart';
import 'package:mosafer/features/auth/presentation/auth_error_message.dart';
import 'package:mosafer/features/home/application/trip_providers.dart';
import 'package:mosafer/features/home/domain/entities/trip.dart';
import 'package:mosafer/l10n/app_localizations_en.dart';

void main() {
  test('maps invalid phone input to a localized message', () {
    expect(
      authErrorMessage(
        AppLocalizationsEn(),
        const AuthFailure(AuthFailureType.invalidPhone),
      ),
      contains('country calling code'),
    );
  });

  test('continues with normalized international phone number', () async {
    final repository = DemoAuthRepository();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);

    await container
        .read(authControllerProvider.notifier)
        .continueWithPhone(phone: '+20 (10) 1234-5678');

    expect(repository.currentUser?.phone, '+201012345678');
    expect(container.read(authControllerProvider).hasError, isFalse);
  });

  test('rejects phone number without country calling code', () async {
    final repository = DemoAuthRepository();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    addTearDown(container.dispose);
    await container.read(authControllerProvider.future);

    await container
        .read(authControllerProvider.notifier)
        .continueWithPhone(phone: '01012345678');

    expect(repository.currentUser, isNull);
    expect(
      (container.read(authControllerProvider).error as AuthFailure).type,
      AuthFailureType.invalidPhone,
    );
  });

  testWidgets('onboarding opens phone-only demo entry', (tester) async {
    final repository = DemoAuthRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('اعرف موقعك بدقة'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('Know exactly where you are'), findsOneWidget);
    expect(find.text('العربية'), findsOneWidget);
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    expect(find.text('اعرف موقعك بدقة'), findsOneWidget);
    await tester.tap(find.text('المتابعة برقم الهاتف'));
    await tester.pumpAndSettle();

    expect(find.text('المتابعة برقم الهاتف'), findsOneWidget);
    expect(find.text('Email address'), findsNothing);
    expect(find.text('Password'), findsNothing);
    expect(find.text('Create account'), findsNothing);
    expect(find.text('أدخل رقم الهاتف'), findsOneWidget);
    expect(find.textContaining('+2'), findsNothing);
    expect(find.textContaining('لم يتم التحقق'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(
      tester.widget<TextFormField>(find.byType(TextFormField)).controller?.text,
      isEmpty,
    );
  });

  testWidgets('phone-only entry opens the app and signout returns to intro',
      (tester) async {
    final repository = DemoAuthRepository();
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with phone number'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), '+201012345678');
    await tester.tap(find.widgetWithText(AppButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(repository.currentUser?.phone, '+201012345678');
    expect(repository.currentUser?.id, 'temporary-demo-session');
    expect(find.text('Where are you going?'), findsOneWidget);

    await tester.tap(find.byTooltip('Sign out'));
    await tester.pumpAndSettle();

    expect(repository.currentUser, isNull);
    expect(find.text('Know exactly where you are'), findsOneWidget);
  });
}

Widget _app(DemoAuthRepository repository) {
  return ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWith((ref) => repository),
      upcomingTripsProvider.overrideWith((ref) async => [_demoTrip()]),
    ],
    child: const MosaferApp(),
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
