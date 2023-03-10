import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme();

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Anybody',
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.black,
        onPrimary: AppColors.white,
        secondary: AppColors.green,
        onSecondary: AppColors.black,
        error: AppColors.red,
      ),
      fontFamily: 'Anybody',
    );
  }
}

@immutable
class AppColors {
  static const Color white = const Color(0xFFFFFFFF);
  static const Color black = const Color(0xFF1E1E1E);
  static const Color green = const Color(0xFFB9EFC9);
  static const Color gray = const Color(0xFF443D3D);
  static const Color red = const Color(0xFFFF3D3D);

  const AppColors();
}
