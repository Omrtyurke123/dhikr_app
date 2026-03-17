import 'package:flutter/material.dart';

class AppTheme {
  // Colors from the reference image
  static const Color darkBg = Color(0xFF1A1F1A);
  static const Color cardBg = Color(0xFF252B25);
  static const Color accentGreen = Color(0xFF6B8F3E);
  static const Color lightGreen = Color(0xFF8BB547);
  static const Color textPrimary = Color(0xFFE8E8E8);
  static const Color textSecondary = Color(0xFF9BA89B);
  static const Color morningGradStart = Color(0xFF87CEEB);
  static const Color morningGradEnd = Color(0xFFFFB347);
  static const Color eveningGradStart = Color(0xFF1A237E);
  static const Color eveningGradEnd = Color(0xFF4A148C);
  static const Color nightGradStart = Color(0xFF0D47A1);
  static const Color nightGradEnd = Color(0xFF1B1B2F);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: accentGreen,
      fontFamily: 'Scheherazade',
      colorScheme: const ColorScheme.dark(
        primary: accentGreen,
        secondary: lightGreen,
        surface: cardBg,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontFamily: 'Scheherazade',
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: textPrimary, fontSize: 28, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textPrimary, fontSize: 22),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      ),
    );
  }
}
