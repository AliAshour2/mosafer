enum AuthFailureType {
  invalidPhone,
}

class AuthFailure implements Exception {
  const AuthFailure(this.type);

  final AuthFailureType type;
}
