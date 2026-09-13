import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
  );
}
