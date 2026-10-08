import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosafer/core/design_system/app_design_system.dart';

void main() {
  group('Design system themes', () {
    test('light theme uses the brand palette and semantic colors', () {
      final theme = buildLightTheme();

      expect(theme.colorScheme.primary, AppColors.primary);
      expect(theme.scaffoldBackgroundColor, AppColors.background);
      expect(
        theme.extension<AppSemanticColors>()?.success,
        AppColors.successForeground,
      );
    });

    test('dark theme provides distinct semantic and surface colors', () {
      final theme = buildDarkTheme();

      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.surface, AppColors.darkSurface);
      expect(
        theme.extension<AppSemanticColors>()?.success,
        AppColors.darkSuccess,
      );
    });

    test('typography defines the Latin family and Arabic fallback', () {
      final style = AppTypography.textTheme.bodyMedium!;

      expect(style.fontFamily, AppTypography.latinFontFamily);
      expect(
          style.fontFamilyFallback, contains(AppTypography.arabicFontFamily));
      expect(style.fontWeight, AppTypography.regular);
    });

    test('semantic foregrounds meet normal text contrast on their surfaces',
        () {
      final light = AppSemanticColors.light;
      final dark = AppSemanticColors.dark;
      final pairs = [
        (light.success, light.successContainer),
        (light.warning, light.warningContainer),
        (light.error, light.errorContainer),
        (light.info, light.infoContainer),
        (dark.success, dark.successContainer),
        (dark.warning, dark.warningContainer),
        (dark.error, dark.errorContainer),
        (dark.info, dark.infoContainer),
      ];

      for (final (foreground, background) in pairs) {
        expect(
          _contrastRatio(foreground, background),
          greaterThanOrEqualTo(4.5),
        );
      }
    });
  });

  testWidgets('Arabic locale establishes RTL direction', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: Builder(
          builder: (context) => Text(
            Directionality.of(context) == TextDirection.rtl ? 'rtl' : 'ltr',
          ),
        ),
      ),
    );

    expect(find.text('rtl'), findsOneWidget);
  });

  testWidgets('loading buttons disable interaction and announce progress', (
    tester,
  ) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: buildLightTheme(),
        home: Scaffold(
          body: AppButton(
            label: 'Continue',
            isLoading: true,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull);
    await tester.tap(find.byType(ElevatedButton));
    expect(pressed, isFalse);
  });

  testWidgets('icon button provides a 48 pixel target and tooltip', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildLightTheme(),
        home: Scaffold(
          body: AppIconButton(
            icon: Icons.search,
            semanticLabel: 'Search',
            onPressed: () {},
          ),
        ),
      ),
    );

    final buttonSize = tester.getSize(find.byType(IconButton));
    expect(buttonSize.width, greaterThanOrEqualTo(AppSizes.minimumTapTarget));
    expect(buttonSize.height, greaterThanOrEqualTo(AppSizes.minimumTapTarget));
    expect(
      tester.widget<IconButton>(find.byType(IconButton)).tooltip,
      'Search',
    );
  });

  test('bundled typefaces are available as local assets', () async {
    final inter = await rootBundle.load('assets/fonts/inter/inter-regular.ttf');
    final arabic = await rootBundle.load(
      'assets/fonts/ibm_plex_sans_arabic/ibm-plex-sans-arabic-regular.ttf',
    );

    expect(inter.lengthInBytes, greaterThan(0));
    expect(arabic.lengthInBytes, greaterThan(0));
  });
}

double _contrastRatio(Color first, Color second) {
  final firstLuminance = first.computeLuminance();
  final secondLuminance = second.computeLuminance();
  final lighter =
      firstLuminance > secondLuminance ? firstLuminance : secondLuminance;
  final darker =
      firstLuminance > secondLuminance ? secondLuminance : firstLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}
