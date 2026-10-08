import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF00A88F);
  static const primaryDark = Color(0xFF008F7A);
  static const primaryLight = Color(0xFFE6F7F4);
  static const onPrimary = Color(0xFF003A32);
  static const onPrimaryContainer = primaryDark;
  static const onSecondary = Color(0xFFFFFFFF);
  static const onError = Color(0xFFFFFFFF);
  static const onErrorContainer = Color(0xFF7F1D1D);
  static const darkPrimary = Color(0xFF50D5BF);
  static const darkOnPrimary = Color(0xFF00372F);
  static const darkPrimaryOnContainer = Color(0xFFA9F2E3);
  static const darkOnError = Color(0xFF3B1010);
  static const darkOnErrorContainer = Color(0xFFFECACA);

  static const background = Color(0xFFF7F8F6);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF3F4F6);
  static const textPrimary = Color(0xFF171717);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);
  static const border = Color(0xFFE5E7EB);
  static const divider = Color(0xFFEEF0F0);
  static const disabledBackground = Color(0xFFF3F4F6);
  static const disabledText = Color(0xFF9CA3AF);

  static const success = Color(0xFF16A34A);
  static const successForeground = Color(0xFF166534);
  static const successLight = Color(0xFFDCFCE7);
  static const warning = Color(0xFFF59E0B);
  static const warningForeground = Color(0xFF92400E);
  static const warningLight = Color(0xFFFEF3C7);
  static const error = Color(0xFFDC2626);
  static const errorForeground = Color(0xFFB91C1C);
  static const errorLight = Color(0xFFFEE2E2);
  static const info = Color(0xFF2563EB);
  static const infoForeground = Color(0xFF1D4ED8);
  static const infoLight = Color(0xFFDBEAFE);

  static const darkBackground = Color(0xFF111513);
  static const darkSurface = Color(0xFF1A211F);
  static const darkSurfaceVariant = Color(0xFF252D2A);
  static const darkTextPrimary = Color(0xFFF3F4F4);
  static const darkTextSecondary = Color(0xFFB0BAB6);
  static const darkTextTertiary = Color(0xFF89948F);
  static const darkBorder = Color(0xFF35403C);
  static const darkDivider = Color(0xFF2A332F);
  static const darkDisabledBackground = Color(0xFF252D2A);
  static const darkDisabledText = Color(0xFF89948F);

  static const darkSuccess = Color(0xFF4ADE80);
  static const darkSuccessContainer = Color(0xFF12351F);
  static const darkWarning = Color(0xFFFBBF24);
  static const darkWarningContainer = Color(0xFF3A2D0D);
  static const darkError = Color(0xFFF87171);
  static const darkErrorContainer = Color(0xFF3D1717);
  static const darkInfo = Color(0xFF60A5FA);
  static const darkInfoContainer = Color(0xFF142C47);
  static const darkPrimaryContainer = Color(0xFF123B34);
}

@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.error,
    required this.errorContainer,
    required this.info,
    required this.infoContainer,
    required this.border,
    required this.divider,
    required this.disabledBackground,
    required this.disabledForeground,
  });

  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color error;
  final Color errorContainer;
  final Color info;
  final Color infoContainer;
  final Color border;
  final Color divider;
  final Color disabledBackground;
  final Color disabledForeground;

  static const light = AppSemanticColors(
    success: AppColors.successForeground,
    successContainer: AppColors.successLight,
    warning: AppColors.warningForeground,
    warningContainer: AppColors.warningLight,
    error: AppColors.errorForeground,
    errorContainer: AppColors.errorLight,
    info: AppColors.infoForeground,
    infoContainer: AppColors.infoLight,
    border: AppColors.border,
    divider: AppColors.divider,
    disabledBackground: AppColors.disabledBackground,
    disabledForeground: AppColors.disabledText,
  );

  static const dark = AppSemanticColors(
    success: AppColors.darkSuccess,
    successContainer: AppColors.darkSuccessContainer,
    warning: AppColors.darkWarning,
    warningContainer: AppColors.darkWarningContainer,
    error: AppColors.darkError,
    errorContainer: AppColors.darkErrorContainer,
    info: AppColors.darkInfo,
    infoContainer: AppColors.darkInfoContainer,
    border: AppColors.darkBorder,
    divider: AppColors.darkDivider,
    disabledBackground: AppColors.darkDisabledBackground,
    disabledForeground: AppColors.darkDisabledText,
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? error,
    Color? errorContainer,
    Color? info,
    Color? infoContainer,
    Color? border,
    Color? divider,
    Color? disabledBackground,
    Color? disabledForeground,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
    );
  }

  @override
  AppSemanticColors lerp(
    covariant ThemeExtension<AppSemanticColors>? other,
    double t,
  ) {
    if (other is! AppSemanticColors) return this;

    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      disabledBackground:
          Color.lerp(disabledBackground, other.disabledBackground, t)!,
      disabledForeground:
          Color.lerp(disabledForeground, other.disabledForeground, t)!,
    );
  }
}
