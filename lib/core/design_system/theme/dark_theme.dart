import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_sizes.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

ThemeData buildDarkTheme() {
  const colorScheme = ColorScheme.dark(
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkPrimaryOnContainer,
    secondary: AppColors.darkPrimary,
    onSecondary: AppColors.darkOnPrimary,
    secondaryContainer: AppColors.darkPrimaryContainer,
    onSecondaryContainer: AppColors.darkPrimaryOnContainer,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    errorContainer: AppColors.darkErrorContainer,
    onErrorContainer: AppColors.darkOnErrorContainer,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkDivider,
  );
  final textTheme = AppTypography.textTheme.apply(
    bodyColor: AppColors.darkTextPrimary,
    displayColor: AppColors.darkTextPrimary,
  );
  final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.medium),
    borderSide: const BorderSide(color: AppColors.darkBorder),
  );

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    canvasColor: AppColors.darkBackground,
    textTheme: textTheme,
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[AppSemanticColors.dark],
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkTextPrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: textTheme.titleLarge,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        borderSide: const BorderSide(
          color: AppColors.darkPrimary,
          width: AppSizes.focusBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        borderSide: const BorderSide(color: AppColors.darkError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        borderSide: const BorderSide(
          color: AppColors.darkError,
          width: AppSizes.focusBorderWidth,
        ),
      ),
      labelStyle:
          textTheme.bodyMedium?.copyWith(color: AppColors.darkTextSecondary),
      hintStyle:
          textTheme.bodyMedium?.copyWith(color: AppColors.darkTextSecondary),
      errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.darkError),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: AppColors.darkDisabledBackground,
        disabledForegroundColor: AppColors.darkDisabledText,
        minimumSize: const Size(64, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: AppRadius.mediumShape,
        textStyle: textTheme.labelLarge,
        elevation: 0,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.darkDisabledBackground;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.brandPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.brandHover;
          }
          return AppColors.brand;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.darkDisabledText;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.surface;
          }
          return AppColors.ink;
        }),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: AppRadius.mediumShape,
        textStyle: textTheme.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkTextPrimary,
        minimumSize: const Size(64, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: AppRadius.mediumShape,
        side: const BorderSide(color: AppColors.darkBorder),
        textStyle: textTheme.labelLarge,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        minimumSize:
            const Size(AppSizes.minimumTapTarget, AppSizes.minimumTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        shape: AppRadius.mediumShape,
        textStyle: textTheme.labelLarge,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: AppSizes.borderWidth,
      space: AppSizes.borderWidth,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xlarge),
      ),
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyMedium,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: AppColors.darkSurface,
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xlarge),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      indicatorColor: AppColors.darkPrimaryContainer,
      elevation: 0,
      labelTextStyle: WidgetStatePropertyAll(textTheme.labelSmall),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.darkPrimary,
      linearTrackColor: AppColors.darkPrimaryContainer,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.darkSurfaceVariant,
      contentTextStyle:
          textTheme.bodyMedium?.copyWith(color: AppColors.darkTextPrimary),
      shape: AppRadius.mediumShape,
    ),
    iconTheme: const IconThemeData(color: AppColors.darkTextSecondary),
  );
}
