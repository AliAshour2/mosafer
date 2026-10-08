import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://lyhjolghswirstktvzfy.supabase.co',
  );
  const supabasePublishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  if (supabasePublishableKey.isEmpty) {
    throw StateError(
      'Missing SUPABASE_PUBLISHABLE_KEY. '
      'Pass it with --dart-define=SUPABASE_PUBLISHABLE_KEY=...',
    );
  }

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );
}
