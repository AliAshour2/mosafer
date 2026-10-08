import 'package:flutter/material.dart';

import '../core/design_system/theme/dark_theme.dart';
import '../core/design_system/theme/light_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = buildLightTheme();
  static final ThemeData darkTheme = buildDarkTheme();
}
