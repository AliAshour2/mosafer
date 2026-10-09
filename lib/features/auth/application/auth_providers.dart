import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositories/demo_auth_repository.dart';
import '../domain/entities/auth_input_validator.dart';
import '../domain/entities/auth_failure.dart';
import '../domain/entities/auth_user.dart';
import '../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final repository = DemoAuthRepository();
  ref.onDispose(repository.dispose);
  return repository;
}

@riverpod
Stream<AuthUser?> authState(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> continueWithPhone({required String phone}) async {
    final normalizedPhone = AuthInputValidator.normalizePhone(phone);
    state = const AsyncLoading();
    if (normalizedPhone == null ||
        !AuthInputValidator.isValidPhone(normalizedPhone)) {
      state = AsyncError(
        const AuthFailure(AuthFailureType.invalidPhone),
        StackTrace.current,
      );
      return;
    }
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .continueWithPhone(phone: normalizedPhone),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signOut(),
    );
  }

  void clearError() {
    if (state.hasError) state = const AsyncData(null);
  }
}
