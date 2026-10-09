import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/app/app.dart';
import 'package:mosafer/core/design_system/components/buttons/app_button.dart';
import 'package:mosafer/features/auth/application/auth_providers.dart';
import 'package:mosafer/features/auth/domain/entities/auth_failure.dart';
import 'package:mosafer/features/auth/domain/entities/auth_input_validator.dart';
import 'package:mosafer/features/auth/domain/entities/auth_user.dart';
import 'package:mosafer/features/auth/domain/entities/user_profile.dart';
import 'package:mosafer/features/auth/domain/repositories/auth_repository.dart';
import 'package:mosafer/features/auth/presentation/auth_error_message.dart';
import 'package:mosafer/features/home/application/trip_providers.dart';
import 'package:mosafer/features/home/domain/entities/trip.dart';
import 'package:mosafer/l10n/app_localizations_en.dart';

void main() {
  test('maps invalid profile values to localized messages', () {
    expect(
      authErrorMessage(
        AppLocalizationsEn(),
        const AuthFailure(AuthFailureType.invalidPhone),
      ),
      contains('country calling code'),
    );
  });

  test('normalizes and validates profile data', () {
    expect(AuthInputValidator.normalizeName('  Ali   Ashour '), 'Ali Ashour');
    expect(
      AuthInputValidator.normalizePhone('+20 (10) 1234-5678'),
      '+201012345678',
    );
    expect(
      AuthInputValidator.isValidPhone(
        AuthInputValidator.normalizePhone('+20 (10) 1234-5678')!,
      ),
      isTrue,
    );
    expect(
      AuthInputValidator.isValidPhone(
        AuthInputValidator.normalizePhone('01012345678')!,
      ),
      isFalse,
    );
  });

  test('signs in through the Google auth repository method', () async {
    final repository = FakeAuthRepository();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(repository.dispose);
    await container.read(authControllerProvider.future);

    await container.read(authControllerProvider.notifier).signInWithGoogle();

    expect(repository.googleSignInCalled, isTrue);
    expect(repository.currentUser?.email, 'traveler@example.com');
  });

  test('rejects invalid profile data before saving it', () async {
    final repository = FakeAuthRepository()..signInUser();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWith((ref) => repository),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(repository.dispose);
    await container.read(authControllerProvider.future);

    await container.read(authControllerProvider.notifier).completeProfile(
          fullName: '  ',
          phone: '01012345678',
        );

    expect(repository.profile, isNull);
    expect(
      (container.read(authControllerProvider).error as AuthFailure).type,
      AuthFailureType.invalidName,
    );
  });

  testWidgets('Google signup collects profile details before opening Home',
      (tester) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.dispose);
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('اعرف موقعك بدقة'), findsOneWidget);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(repository.googleSignInCalled, isTrue);
    expect(find.text('A few details'), findsOneWidget);
    expect(find.text('Google Traveler'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.textContaining('No verification code'), findsOneWidget);

    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('profile-name')),
        matching: find.byType(TextFormField),
      ),
      'Mosafer Rider',
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('profile-phone')),
        matching: find.byType(TextFormField),
      ),
      '+20 (10) 1234-5678',
    );
    await tester.tap(find.widgetWithText(AppButton, 'Save and continue'));
    await tester.pumpAndSettle();

    expect(repository.profile?.fullName, 'Mosafer Rider');
    expect(repository.profile?.phone, '+201012345678');
    expect(find.text('Mosafer Rider'), findsOneWidget);
    expect(find.text('Where are you going?'), findsOneWidget);
  });

  testWidgets('returning users with a profile land directly on Home',
      (tester) async {
    final repository = FakeAuthRepository()
      ..signInUser()
      ..profile = const UserProfile(
        id: 'google-user',
        fullName: 'Returning Traveler',
        phone: '+201012345678',
      );
    addTearDown(repository.dispose);
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.text('إلى أين تريد الذهاب؟'), findsOneWidget);
    expect(find.text('Returning Traveler'), findsOneWidget);
  });
}

Widget _app(FakeAuthRepository repository) {
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

class FakeAuthRepository implements AuthRepository {
  final StreamController<AuthUser?> _authChanges =
      StreamController<AuthUser?>.broadcast();

  AuthUser? _currentUser;
  bool googleSignInCalled = false;
  UserProfile? profile;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Stream<AuthUser?> get authStateChanges => _authChanges.stream;

  @override
  Future<void> signInWithGoogle() async {
    googleSignInCalled = true;
    signInUser();
  }

  void signInUser() {
    _currentUser = const AuthUser(
      id: 'google-user',
      email: 'traveler@example.com',
      displayName: 'Google Traveler',
    );
    _authChanges.add(_currentUser);
  }

  @override
  Future<UserProfile?> getCurrentProfile() async => profile;

  @override
  Future<void> saveProfile({
    required String fullName,
    required String phone,
  }) async {
    final user = _currentUser;
    if (user == null) throw StateError('User is not signed in.');
    profile = UserProfile(id: user.id, fullName: fullName, phone: phone);
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    profile = null;
    _authChanges.add(null);
  }

  Future<void> dispose() => _authChanges.close();
}
