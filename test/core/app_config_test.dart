import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('accepts a production URL and a Supabase publishable key', () {
      final config = AppConfig.fromValues(
        environment: 'production',
        supabaseUrl: 'https://example.supabase.co/',
        supabasePublishableKey: 'sb_publishable_example',
      );

      expect(config.environment, AppEnvironment.production);
      expect(config.supabaseUrl, 'https://example.supabase.co');
      expect(config.supabasePublishableKey, 'sb_publishable_example');
    });

    test('accepts the legacy anonymous JWT key format', () {
      final payload = base64Url.encode(utf8.encode('{"role":"anon"}'));
      final config = AppConfig.fromValues(
        environment: 'staging',
        supabaseUrl: 'https://example.supabase.co',
        supabasePublishableKey: 'header.$payload.signature',
      );

      expect(config.environment, AppEnvironment.staging);
    });

    test('accepts HTTP only for local development', () {
      final config = AppConfig.fromValues(
        environment: 'development',
        supabaseUrl: 'http://127.0.0.1:54321',
        supabasePublishableKey: 'sb_publishable_example',
      );

      expect(config.supabaseUrl, 'http://127.0.0.1:54321');
    });

    test('rejects missing or invalid environment values', () {
      expect(
        () => AppConfig.fromValues(
          environment: '',
          supabaseUrl: 'https://example.supabase.co',
          supabasePublishableKey: 'sb_publishable_example',
        ),
        throwsA(isA<AppConfigurationException>()),
      );
      expect(
        () => AppConfig.fromValues(
          environment: 'preview',
          supabaseUrl: 'https://example.supabase.co',
          supabasePublishableKey: 'sb_publishable_example',
        ),
        throwsA(isA<AppConfigurationException>()),
      );
    });

    test('rejects non-HTTPS remote URLs and non-local HTTP URLs', () {
      for (final url in [
        'http://example.supabase.co',
        'https://user:password@example.supabase.co',
        'https://example.supabase.co?token=secret',
        'not a URL',
      ]) {
        expect(
          () => AppConfig.fromValues(
            environment: 'production',
            supabaseUrl: url,
            supabasePublishableKey: 'sb_publishable_example',
          ),
          throwsA(isA<AppConfigurationException>()),
        );
      }
    });

    test('rejects server secrets and non-anon legacy JWT keys', () {
      final serviceRole = base64Url.encode(
        utf8.encode('{"role":"service_role"}'),
      );

      for (final key in [
        '',
        'sb_secret_example',
        'header.$serviceRole.signature',
        'not-a-key',
      ]) {
        expect(
          () => AppConfig.fromValues(
            environment: 'development',
            supabaseUrl: 'https://example.supabase.co',
            supabasePublishableKey: key,
          ),
          throwsA(isA<AppConfigurationException>()),
        );
      }
    });
  });
}
