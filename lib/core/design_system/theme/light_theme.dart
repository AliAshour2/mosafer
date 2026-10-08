import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_sizes.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

ThemeData buildLightTheme() {
  const colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondary: AppColors.primaryDark,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    outline: AppColors.border,
    outlineVariant: AppColors.divider,
  );
  final textTheme = AppTypography.textTheme.apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  );
  final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.medium),
    borderSide: const BorderSide(color: AppColors.border),
  );

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.background,
    textTheme: textTheme,
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[AppSemanticColors.light],
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: textTheme.titleLarge,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: AppSizes.focusBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: AppSizes.focusBorderWidth,
        ),
      ),
      labelStyle:
          textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
      hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
      errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.error),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: AppColors.disabledBackground,
        disabledForegroundColor: AppColors.disabledText,
        minimumSize: const Size(64, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: AppRadius.mediumShape,
        textStyle: textTheme.labelLarge,
        elevation: 0,
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
        foregroundColor: AppColors.textPrimary,
        minimumSize: const Size(64, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        shape: AppRadius.mediumShape,
        side: const BorderSide(color: AppColors.border),
        textStyle: textTheme.labelLarge,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        minimumSize:
            const Size(AppSizes.minimumTapTarget, AppSizes.minimumTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        shape: AppRadius.mediumShape,
        textStyle: textTheme.labelLarge,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: AppSizes.borderWidth,
      space: AppSizes.borderWidth,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xlarge),
      ),
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyMedium,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: AppColors.surface,
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xlarge),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryLight,
      elevation: 0,
      labelTextStyle: WidgetStatePropertyAll(textTheme.labelSmall),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryDark,
      linearTrackColor: AppColors.primaryLight,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.textPrimary,
      contentTextStyle:
          textTheme.bodyMedium?.copyWith(color: AppColors.surface),
      shape: AppRadius.mediumShape,
    ),
    iconTheme: const IconThemeData(color: AppColors.textSecondary),
  );
}
