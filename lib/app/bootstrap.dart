import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MissingSupabasePublishableKeyException implements Exception {
  const MissingSupabasePublishableKeyException();
}

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://lyhjolghswirstktvzfy.supabase.co',
  );
  const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_r9pIncAymqo-hs9igmSPoA_9T0HJUGz',
  );

  if (supabasePublishableKey.isEmpty) {
    throw const MissingSupabasePublishableKeyException();
  }

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );
}
