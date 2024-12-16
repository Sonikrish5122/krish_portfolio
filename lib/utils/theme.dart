import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  // Light theme data
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    hintColor: AppColors.lightAccent,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.lightText),
      bodyLarge: TextStyle(color: AppColors.lightSubText),
    ),
  );

  // Dark theme data
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    hintColor: AppColors.darkAccent,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.darkText),
      bodyLarge: TextStyle(color: AppColors.darkSubText),
    ),
  );
}
