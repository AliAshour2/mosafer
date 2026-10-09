import 'dart:convert';

enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment parse(String value) {
    return switch (value.trim().toLowerCase()) {
      'development' => AppEnvironment.development,
      'staging' => AppEnvironment.staging,
      'production' => AppEnvironment.production,
      _ => throw const AppConfigurationException(),
    };
  }
}

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.supabaseUrl,
    required this.supabasePublishableKey,
  });

  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabasePublishableKey;

  static const _environment = String.fromEnvironment('APP_ENV');
  static const _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const _supabasePublishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  factory AppConfig.fromEnvironment() {
    return AppConfig.fromValues(
      environment: _environment,
      supabaseUrl: _supabaseUrl,
      supabasePublishableKey: _supabasePublishableKey,
    );
  }

  factory AppConfig.fromValues({
    required String environment,
    required String supabaseUrl,
    required String supabasePublishableKey,
  }) {
    final parsedEnvironment = AppEnvironment.parse(environment);
    final normalizedUrl = _validateSupabaseUrl(
      supabaseUrl,
      parsedEnvironment,
    );
    final normalizedKey = _validatePublishableKey(supabasePublishableKey);

    return AppConfig(
      environment: parsedEnvironment,
      supabaseUrl: normalizedUrl,
      supabasePublishableKey: normalizedKey,
    );
  }

  static String _validateSupabaseUrl(
    String value,
    AppEnvironment environment,
  ) {
    final normalized = value.trim();
    final uri = Uri.tryParse(normalized);
    if (uri == null ||
        !uri.isAbsolute ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment) {
      throw const AppConfigurationException();
    }

    final isLocalHost =
        uri.host == 'localhost' || uri.host == '127.0.0.1' || uri.host == '::1';
    if (uri.scheme != 'https' &&
        !(environment == AppEnvironment.development &&
            uri.scheme == 'http' &&
            isLocalHost)) {
      throw const AppConfigurationException();
    }

    return normalized.replaceFirst(RegExp(r'/+$'), '');
  }

  static String _validatePublishableKey(String value) {
    final key = value.trim();
    if (key.isEmpty || key.startsWith('sb_secret_')) {
      throw const AppConfigurationException();
    }

    if (key.startsWith('sb_publishable_')) return key;

    final segments = key.split('.');
    if (segments.length != 3) {
      throw const AppConfigurationException();
    }
    try {
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
      );
      if (payload is Map<String, dynamic> && payload['role'] == 'anon') {
        return key;
      }
    } on FormatException {
      throw const AppConfigurationException();
    }

    throw const AppConfigurationException();
  }
}

class AppConfigurationException implements Exception {
  const AppConfigurationException();
}
