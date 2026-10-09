import '../entities/auth_user.dart';
import '../entities/user_profile.dart';

abstract interface class AuthRepository {
  AuthUser? get currentUser;

  Stream<AuthUser?> get authStateChanges;

  Future<void> signInWithGoogle();

  Future<UserProfile?> getCurrentProfile();

  Future<void> saveProfile({
    required String fullName,
    required String phone,
  });

  Future<void> signOut();
}
