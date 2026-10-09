import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

const authRedirectUri = 'com.example.mosafer://login-callback';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

  @override
  AuthUser? get currentUser {
    final user = _client.auth.currentUser;
    return user == null ? null : _mapUser(user);
  }

  @override
  Stream<AuthUser?> get authStateChanges {
    return _client.auth.onAuthStateChange.map((state) {
      final user = state.session?.user;
      return user == null ? null : _mapUser(user);
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb ? Uri.base.origin : authRedirectUri,
    );
  }

  @override
  Future<UserProfile?> getCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final row = await _client
        .from('profiles')
        .select('id, full_name, phone')
        .eq('id', user.id)
        .maybeSingle();
    if (row == null) return null;
    return UserProfile.fromMap(row);
  }

  @override
  Future<void> saveProfile({
    required String fullName,
    required String phone,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException(
          'A signed-in user is required to save a profile.');
    }

    await _client.from('profiles').upsert({
      'id': user.id,
      'full_name': fullName,
      'phone': phone,
    });
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  AuthUser _mapUser(User user) {
    final metadata = user.userMetadata ?? const <String, dynamic>{};
    final name = metadata['full_name'] ?? metadata['name'];
    return AuthUser(
      id: user.id,
      email: user.email,
      displayName: name is String ? name : null,
    );
  }
}
