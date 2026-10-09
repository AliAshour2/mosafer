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
      expect(AppColors.ink, const Color(0xFF000000));
      expect(AppColors.surface, const Color(0xFFFFFFFF));
      expect(AppColors.surfaceMuted, const Color(0xFFF6F6F6));
      expect(AppColors.brand, const Color(0xFF009A62));
      expect(AppColors.brandDark, const Color(0xFF007A4D));
      expect(AppColors.brandDarker, const Color(0xFF00603D));
      expect(AppColors.brandLight, const Color(0xFFE4F5EE));
      expect(AppColors.brandHover, const Color(0xFF008A57));
      expect(AppColors.brandPressed, AppColors.brandDark);
      expect(
        [
          AppColors.gray50,
          AppColors.gray100,
          AppColors.gray200,
          AppColors.gray300,
          AppColors.gray400,
          AppColors.gray500,
          AppColors.gray600,
          AppColors.gray700,
          AppColors.gray800,
          AppColors.gray900,
        ],
        [
          const Color(0xFFF6F6F6),
          const Color(0xFFEEEEEE),
          const Color(0xFFE2E2E2),
          const Color(0xFFCBCBCB),
          const Color(0xFFAFAFAF),
          const Color(0xFF757575),
          const Color(0xFF545454),
          const Color(0xFF333333),
          const Color(0xFF1F1F1F),
          const Color(0xFF000000),
        ],
      );
      expect(AppColors.success, const Color(0xFF059669));
      expect(AppColors.warning, const Color(0xFFF59E0B));
      expect(AppColors.error, const Color(0xFFDC2626));
      expect(AppColors.info, const Color(0xFF2563EB));
      expect(theme.colorScheme.onPrimary, AppColors.ink);
      expect(theme.inputDecorationTheme.fillColor, AppColors.surfaceMuted);
      expect(
        _contrastRatio(theme.colorScheme.onPrimary, theme.colorScheme.primary),
        greaterThanOrEqualTo(4.5),
      );
      final buttonStyle = theme.elevatedButtonTheme.style!;
      expect(
        buttonStyle.backgroundColor?.resolve({WidgetState.hovered}),
        AppColors.brandHover,
      );
      expect(
        buttonStyle.backgroundColor?.resolve({WidgetState.pressed}),
        AppColors.brandPressed,
      );
      expect(
        buttonStyle.foregroundColor?.resolve({WidgetState.pressed}),
        AppColors.surface,
      );
      expect(
        _contrastRatio(
          buttonStyle.foregroundColor!.resolve({WidgetState.pressed})!,
          buttonStyle.backgroundColor!.resolve({WidgetState.pressed})!,
        ),
        greaterThanOrEqualTo(4.5),
      );
      expect(theme.scaffoldBackgroundColor, AppColors.background);
      expect(
        theme.extension<AppSemanticColors>()?.success,
        AppColors.successForeground,
      );
    });

    test('dark theme provides distinct semantic and surface colors', () {
      final theme = buildDarkTheme();

      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, AppColors.ink);
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

    test('typography follows the product scale and includes code type', () {
      final textTheme = AppTypography.textTheme;

      expect(textTheme.headlineLarge?.fontSize, 32);
      expect(textTheme.headlineLarge?.fontWeight, AppTypography.bold);
      expect(textTheme.titleLarge?.fontSize, 20);
      expect(textTheme.titleLarge?.fontWeight, AppTypography.bold);
      expect(textTheme.bodyLarge?.fontSize, 16);
      expect(textTheme.bodyLarge?.fontWeight, AppTypography.medium);
      expect(textTheme.bodyMedium?.fontSize, 14);
      expect(textTheme.bodySmall?.fontSize, 12);
      expect(textTheme.labelSmall?.fontSize, 10);
      expect(textTheme.labelSmall?.fontWeight, AppTypography.semiBold);
      expect(AppTypography.code.fontFamily, AppTypography.monospaceFontFamily);
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
    final mono = await rootBundle.load(
      'assets/fonts/jetbrains_mono/jetbrains-mono-regular.ttf',
    );

    expect(inter.lengthInBytes, greaterThan(0));
    expect(arabic.lengthInBytes, greaterThan(0));
    expect(mono.lengthInBytes, greaterThan(0));
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
