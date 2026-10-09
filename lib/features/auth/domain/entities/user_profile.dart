class UserProfile {
  const UserProfile({
    required this.id,
    required this.fullName,
    required this.phone,
  });

  final String id;
  final String fullName;
  final String phone;

  factory UserProfile.fromMap(Map<String, dynamic> row) {
    final id = row['id'];
    final fullName = row['full_name'];
    final phone = row['phone'];
    if (id is! String || fullName is! String || phone is! String) {
      throw const FormatException('Invalid profile row returned by Supabase.');
    }

    return UserProfile(id: id, fullName: fullName, phone: phone);
  }
}
