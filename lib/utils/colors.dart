import 'package:flutter/material.dart';

class AppColors {
  // Primary and Secondary Colors
  static const Color primary = Color(0xFF0052A1); // Navy Blue for primary elements
  static const Color secondary = Color(0xFF8EC6FF); // Light Sky Blue for highlights

  // Text Colors
  static const Color textPrimary = Color(0xFF333333); // Dark Gray for primary text
  static const Color textSecondary = Color(0xFF666666); // Medium Gray for secondary text
  static const Color textOnPrimary = Colors.white; // White text for contrast on primary color
  static const Color textOnSecondary = Colors.black; // Black text for contrast on secondary color

  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFFFF); // Light mode background
  static const Color backgroundDark = Color(0xFF121212); // Dark mode background

  // Surface Colors
  static const Color surfaceLight = Color(0xFFF5F5F5); // Card surface in light mode
  static const Color surfaceDark = Color(0xFF1E1E1E); // Card surface in dark mode

  // Accent Colors
  static const Color accent = Color(0xFFFFA726); // Orange for buttons and icons

  // Theme Colors
  // Light Theme Colors
  static const Color lightPrimary = primary;
  static const Color lightAccent = accent;
  static const Color lightBackground = backgroundLight;
  static const Color lightSurface = surfaceLight;
  static const Color lightText = textPrimary;
  static const Color lightSubText = textSecondary;

  // Dark Theme Colors
  static const Color darkPrimary = primary;
  static const Color darkAccent = accent;
  static const Color darkBackground = backgroundDark;
  static const Color darkSurface = surfaceDark;
  static const Color darkText = Color(0xFFF5F5F5); // Light text in dark mode
  static const Color darkSubText = Color(0xFFAAAAAA); // Gray for secondary text in dark mode

  // Button Colors
  static const Color buttonPrimary = Color(0xFF00BFFF);
  static const Color buttonSecondary = Color(0xFF1E90FF);

  // Special Colors
  static const Color hoverEffect = secondary; // Hover effect color
  static const Color border = primary; // Border color

  // Gradient Colors
  static const List<Color> gradientPrimary = [
    Color(0xFF4A00E0),
    Color(0xFF8E2DE2),
  ];

  // Error Colors
  static const Color error = Color(0xFFD32F2F); // Error messages and alerts
}
