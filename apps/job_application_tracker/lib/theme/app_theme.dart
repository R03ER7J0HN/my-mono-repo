import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF29323C);
  static const Color _secondaryColor = Color(0xFF485563);
  static const Color _backgroundColor = Color(0xFFF5F7FA);
  static const Color _surfaceColor = Colors.white;
  static const Color _errorColor = Color(0xFFD32F2F);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        error: _errorColor,
        onSecondary: Colors.white,
        onSurface: _primaryColor,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        color: _surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: _primaryColor,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: _primaryColor),
        bodyMedium: TextStyle(color: _secondaryColor),
      ),
    );
  }
}
