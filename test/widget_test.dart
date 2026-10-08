import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mosafer/app/app.dart';

void main() {
  testWidgets('Mosafer app boots with the home route', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MosaferApp(),
      ),
    );

    expect(find.text('Mosafer'), findsWidgets);
    expect(find.text('Foundation ready'), findsOneWidget);
  });
}
