import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final textPrimary = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final textSecondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary, // Ana rengi Mavi yaptık
        brightness: brightness,
      ).copyWith(
        primary: primary,
        secondary: accent, // İkincil renk Işıklı Mor
        surface: surface,
        onSurface: textPrimary,
        outline: border,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        // Başlıklar için modern ve teknolojik Plus Jakarta Sans
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          height: 1.15,
          color: textPrimary,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.3,
          color: textPrimary,
        ),
        // Gövde yazıları için okunabilirliği yüksek Inter
        bodyLarge: GoogleFonts.inter(fontSize: 16, height: 1.6, color: textPrimary),
        bodyMedium: GoogleFonts.inter(fontSize: 14, height: 1.5, color: textSecondary),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 20, 
          fontWeight: FontWeight.w700, 
          color: textPrimary
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          side: BorderSide(color: border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, AppConstants.buttonHeight + 4),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, AppConstants.buttonHeight + 4),
          foregroundColor: textPrimary,
          side: BorderSide(color: border, width: 1.5),
          textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
      ),
    );
  }
}