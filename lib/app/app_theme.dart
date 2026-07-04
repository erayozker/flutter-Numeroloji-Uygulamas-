import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color deepPurple = Color(0xFF100824);
  static const Color royalPurple = Color(0xFF22103F);
  static const Color cardPurple = Color(0xFF2E1854);
  static const Color gold = Color(0xFFF5C85A);
  static const Color softGold = Color(0xFFFFDF8A);
  static const Color moonWhite = Color(0xFFF8F4FF);

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: gold,
      brightness: Brightness.dark,
      primary: gold,
      secondary: softGold,
      surface: royalPurple,
      onPrimary: const Color(0xFF241300),
      onSurface: moonWhite,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: deepPurple,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: moonWhite,
        titleTextStyle: TextStyle(
          color: moonWhite,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: royalPurple.withValues(alpha: 0.96),
        indicatorColor: gold.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return TextStyle(
            color: isSelected ? gold : moonWhite.withValues(alpha: 0.72),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: isSelected ? gold : moonWhite.withValues(alpha: 0.72),
            size: 24,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: cardPurple.withValues(alpha: 0.82),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: gold.withValues(alpha: 0.18)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: const Color(0xFF241300),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A0D32),
        prefixIconColor: gold,
        suffixIconColor: gold,
        labelStyle: TextStyle(color: moonWhite.withValues(alpha: 0.72)),
        hintStyle: TextStyle(color: moonWhite.withValues(alpha: 0.48)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: gold.withValues(alpha: 0.18)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: gold, width: 1.4),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: moonWhite,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        headlineMedium: TextStyle(
          color: moonWhite,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          color: moonWhite,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: moonWhite,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: moonWhite,
          fontSize: 16,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          color: moonWhite,
          fontSize: 14,
          height: 1.45,
        ),
      ),
    );
  }
}
