import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/supabase_client_provider.dart';
import '../data/repositories/supabase_auth_repository.dart';
import '../domain/entities/auth_failure.dart';
import '../domain/entities/auth_input_validator.dart';
import '../domain/entities/auth_user.dart';
import '../domain/entities/user_profile.dart';
import '../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return SupabaseAuthRepository(ref.watch(supabaseClientProvider));
}

@riverpod
Stream<AuthUser?> authState(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
Future<UserProfile?> currentUserProfile(Ref ref) {
  return ref.watch(authRepositoryProvider).getCurrentProfile();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signInWithGoogle(),
    );
  }

  Future<void> completeProfile({
    required String fullName,
    required String phone,
  }) async {
    final normalizedName = AuthInputValidator.normalizeName(fullName);
    final normalizedPhone = AuthInputValidator.normalizePhone(phone);
    if (normalizedName == null) {
      state = AsyncError(
        const AuthFailure(AuthFailureType.invalidName),
        StackTrace.current,
      );
      return;
    }
    if (normalizedPhone == null ||
        !AuthInputValidator.isValidPhone(normalizedPhone)) {
      state = AsyncError(
        const AuthFailure(AuthFailureType.invalidPhone),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).saveProfile(
            fullName: normalizedName,
            phone: normalizedPhone,
          ),
    );
    if (!state.hasError) ref.invalidate(currentUserProfileProvider);
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
