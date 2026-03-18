import 'package:flutter/material.dart';

class AppTheme {
  static const Color bgColor = Color(0xFF1A1F1A);
  static const Color accentGreen = Color(0xFF6B8F3E);
  static const Color cardColor = Color(0xFF252B25);
  static const Color textPrimary = Color(0xFFE8F0E8);
  static const Color textSecondary = Color(0xFF9BAE9B);

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
        primaryColor: accentGreen,
        colorScheme: const ColorScheme.dark(
          primary: accentGreen,
          background: bgColor,
          surface: cardColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
        cardTheme: const CardTheme(
          color: cardColor,
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: accentGreen,
          unselectedLabelColor: textSecondary,
          indicatorColor: accentGreen,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: textPrimary, fontFamily: 'Amiri'),
          bodyMedium: TextStyle(color: textSecondary, fontFamily: 'Amiri'),
        ),
        useMaterial3: false,
      );
}
