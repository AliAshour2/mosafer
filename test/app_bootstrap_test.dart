import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/main.dart';

void main() {
  testWidgets('invalid application config is shown instead of a blank app',
      (tester) async {
    await tester.pumpWidget(const SupabaseConfigurationErrorApp());

    expect(
      find.text('Application configuration missing or invalid'),
      findsOneWidget,
    );
    expect(
      find.textContaining('README.md'),
      findsOneWidget,
    );
  });
}
