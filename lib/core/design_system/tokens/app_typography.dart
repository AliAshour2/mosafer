import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const latinFontFamily = 'Inter';
  static const arabicFontFamily = 'IBM Plex Sans Arabic';
  static const monospaceFontFamily = 'JetBrains Mono';

  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;

  static const fontFamilyFallback = <String>[arabicFontFamily];
  static const code = TextStyle(
    fontFamily: monospaceFontFamily,
    fontFamilyFallback: fontFamilyFallback,
    fontSize: 14,
    height: 1.4,
    fontWeight: regular,
  );

  static TextTheme get textTheme => const TextTheme(
        displayLarge: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 32,
          height: 1.2,
          fontWeight: bold,
        ),
        displayMedium: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 28,
          height: 1.2,
          fontWeight: bold,
        ),
        headlineLarge: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 32,
          height: 1.25,
          fontWeight: bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 24,
          height: 1.25,
          fontWeight: bold,
        ),
        headlineSmall: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 20,
          height: 1.3,
          fontWeight: bold,
        ),
        titleLarge: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 20,
          height: 1.35,
          fontWeight: bold,
        ),
        titleMedium: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 16,
          height: 1.4,
          fontWeight: medium,
        ),
        titleSmall: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 14,
          height: 1.4,
          fontWeight: medium,
        ),
        bodyLarge: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 16,
          height: 1.5,
          fontWeight: medium,
        ),
        bodyMedium: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 14,
          height: 1.5,
          fontWeight: regular,
        ),
        bodySmall: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 12,
          height: 1.45,
          fontWeight: regular,
        ),
        labelLarge: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 14,
          height: 1.35,
          fontWeight: medium,
        ),
        labelMedium: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 12,
          height: 1.35,
          fontWeight: regular,
        ),
        labelSmall: TextStyle(
          fontFamily: latinFontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontSize: 10,
          height: 1.35,
          fontWeight: semiBold,
          letterSpacing: 0.5,
        ),
      );
}
