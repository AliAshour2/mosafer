import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const ink = Color(0xFF000000);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFF6F6F6);
  static const brand = Color(0xFF009A62);
  static const brandDark = Color(0xFF007A4D);
  static const brandDarker = Color(0xFF00603D);
  static const brandLight = Color(0xFFE4F5EE);
  static const brandHover = Color(0xFF008A57);
  static const brandPressed = brandDark;

  static const gray50 = Color(0xFFF6F6F6);
  static const gray100 = Color(0xFFEEEEEE);
  static const gray200 = Color(0xFFE2E2E2);
  static const gray300 = Color(0xFFCBCBCB);
  static const gray400 = Color(0xFFAFAFAF);
  static const gray500 = Color(0xFF757575);
  static const gray600 = Color(0xFF545454);
  static const gray700 = Color(0xFF333333);
  static const gray800 = Color(0xFF1F1F1F);
  static const gray900 = ink;

  static const primary = brand;
  static const primaryDark = brandDark;
  static const primaryLight = brandLight;
  static const onPrimary = ink;
  static const onPrimaryContainer = brandDarker;
  static const onSecondary = Color(0xFFFFFFFF);
  static const onError = Color(0xFFFFFFFF);
  static const onErrorContainer = Color(0xFF7F1D1D);
  static const darkPrimary = brand;
  static const darkOnPrimary = ink;
  static const darkPrimaryOnContainer = brandLight;
  static const darkOnError = Color(0xFF3B1010);
  static const darkOnErrorContainer = Color(0xFFFECACA);

  static const background = surfaceMuted;
  static const surfaceVariant = surfaceMuted;
  static const textPrimary = ink;
  static const textSecondary = gray600;
  static const textTertiary = gray500;
  static const border = gray200;
  static const divider = gray100;
  static const disabledBackground = gray50;
  static const disabledText = gray500;

  static const success = Color(0xFF059669);
  static const successForeground = brandDarker;
  static const successLight = brandLight;
  static const warning = Color(0xFFF59E0B);
  static const warningForeground = Color(0xFF92400E);
  static const warningLight = Color(0xFFFEF3C7);
  static const error = Color(0xFFDC2626);
  static const errorForeground = Color(0xFFB91C1C);
  static const errorLight = Color(0xFFFEE2E2);
  static const info = Color(0xFF2563EB);
  static const infoForeground = Color(0xFF1D4ED8);
  static const infoLight = Color(0xFFDBEAFE);

  static const darkBackground = ink;
  static const darkSurface = gray800;
  static const darkSurfaceVariant = gray700;
  static const darkTextPrimary = gray50;
  static const darkTextSecondary = gray300;
  static const darkTextTertiary = gray400;
  static const darkBorder = gray600;
  static const darkDivider = gray700;
  static const darkDisabledBackground = gray800;
  static const darkDisabledText = gray500;

  static const darkSuccess = Color(0xFF6EE7B7);
  static const darkSuccessContainer = Color(0xFF064E3B);
  static const darkWarning = Color(0xFFFBBF24);
  static const darkWarningContainer = Color(0xFF3A2D0D);
  static const darkError = Color(0xFFF87171);
  static const darkErrorContainer = Color(0xFF3D1717);
  static const darkInfo = Color(0xFF60A5FA);
  static const darkInfoContainer = Color(0xFF142C47);
  static const darkPrimaryContainer = brandDarker;
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
