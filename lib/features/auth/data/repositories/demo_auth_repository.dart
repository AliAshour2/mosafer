import 'dart:async';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';

class DemoAuthRepository implements AuthRepository {
  final StreamController<AuthUser?> _authChanges =
      StreamController<AuthUser?>.broadcast();

  AuthUser? _currentUser;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Stream<AuthUser?> get authStateChanges => _authChanges.stream;

  @override
  Future<void> continueWithPhone({required String phone}) async {
    _currentUser = AuthUser(id: 'temporary-demo-session', phone: phone);
    _authChanges.add(_currentUser);
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _authChanges.add(null);
  }

  Future<void> dispose() => _authChanges.close();
}
