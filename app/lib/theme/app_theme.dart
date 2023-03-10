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
      scaffoldBackgroundColor: Colors.black,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 1,
              color: AppColors.gray,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.black,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.green,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.green,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.black,
          ),
        ),
      ),
      fontFamily: 'Anybody',
    );
  }
}

@immutable
class AppColors {
  static const Color white = const Color(0xFFFFFFFF);
  static const Color black = const Color(0xFF181818);
  static const Color green = const Color(0xFFB9EFC9);
  static const Color gray = const Color(0xFF443D3D);
  static const Color red = const Color(0xFFFF3D3D);

  const AppColors();
}
