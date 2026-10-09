import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/design_system/app_design_system.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  try {
    await bootstrap();
  } on MissingSupabasePublishableKeyException {
    runApp(const SupabaseConfigurationErrorApp());
    return;
  }

  runApp(
    const ProviderScope(
      child: MosaferApp(),
    ),
  );
}

class SupabaseConfigurationErrorApp extends StatelessWidget {
  const SupabaseConfigurationErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mosafer setup',
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: AppErrorState(
          title: 'Supabase configuration missing',
          message:
              'Set SUPABASE_PUBLISHABLE_KEY and restart the app. For example:\n'
              'flutter run -d chrome '
              'sb_publishable_r9pIncAymqo-hs9igmSPoA_9T0HJUGz',
        ),
      ),
    );
  }
}
