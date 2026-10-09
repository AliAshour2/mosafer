class AuthInputValidator {
  AuthInputValidator._();

  static String? normalizeName(String? name) {
    if (name == null || name.trim().isEmpty) return null;
    final normalized = name.trim().replaceAll(RegExp(r'\s+'), ' ');
    return normalized.length <= 100 ? normalized : null;
  }

  static String? normalizePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) return null;
    return _normalizeDigits(phone).replaceAll(RegExp(r'[\s().-]'), '');
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(phone);
  }

  static String _normalizeDigits(String value) {
    return String.fromCharCodes(value.runes.map((rune) {
      if (rune >= 0x0660 && rune <= 0x0669) return rune - 0x0660 + 0x30;
      if (rune >= 0x06F0 && rune <= 0x06F9) return rune - 0x06F0 + 0x30;
      return rune;
    }));
  }
}
