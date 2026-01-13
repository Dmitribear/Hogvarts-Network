import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const navy = Color(0xFF0C1226);
  static const burgundy = Color(0xFF5A1F2A);
  static const gold = Color(0xFFD9A441);
  static const mist = Color(0xFF7C8594);
  static const parchment = Color(0xFFE7DFCF);
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark();
    final textTheme = GoogleFonts.cinzelTextTheme(base.textTheme).apply(
      bodyColor: AppColors.parchment,
      displayColor: AppColors.parchment,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.navy,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.gold,
        secondary: AppColors.burgundy,
        surface: const Color(0xFF11172C),
        onSurface: AppColors.parchment,
        brightness: Brightness.dark,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.parchment,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.04),
        shadowColor: AppColors.gold.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.burgundy,
          foregroundColor: AppColors.parchment,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: textTheme.labelLarge?.copyWith(letterSpacing: 1.1),
          elevation: 8,
          shadowColor: AppColors.gold.withOpacity(0.3),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.04),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.4),
        ),
        labelStyle: TextStyle(color: AppColors.parchment.withOpacity(0.8)),
        hintStyle: TextStyle(color: AppColors.mist.withOpacity(0.7)),
      ),
    );
  }
}
