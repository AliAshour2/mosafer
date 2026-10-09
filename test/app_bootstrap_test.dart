import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/main.dart';

void main() {
  testWidgets('missing Supabase key is shown instead of a blank app',
      (tester) async {
    await tester.pumpWidget(const SupabaseConfigurationErrorApp());

    expect(find.text('Supabase configuration missing'), findsOneWidget);
    expect(
      find.textContaining('SUPABASE_PUBLISHABLE_KEY'),
      findsOneWidget,
    );
  });
}
