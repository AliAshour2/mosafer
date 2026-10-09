import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/design_system/app_design_system.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  try {
    await bootstrap();
  } on AppConfigurationException {
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
          title: 'Application configuration missing or invalid',
          message: 'Create a local configuration file using '
              'config/app_config.example.json and follow the setup '
              'instructions in README.md.',
        ),
      ),
    );
  }
}
