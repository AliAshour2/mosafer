import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mosafer/features/home/presentation/screens/home_screen.dart';
import 'package:mosafer/l10n/app_localizations.dart';
import 'package:mosafer/features/todos/domain/entities/todo.dart';
import 'package:mosafer/features/todos/presentation/providers/todos_provider.dart';

void main() {
  testWidgets('home screen displays todos', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          todosProvider.overrideWith(
            (ref) async => const [Todo(name: 'Test todo')],
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Todos'), findsOneWidget);
    expect(find.text('Test todo'), findsOneWidget);
  });
}
