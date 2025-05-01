import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle _baseTextStyle = GoogleFonts.roboto();

  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: _baseTextStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: AppColors.lightOnBackground),
    displayMedium: _baseTextStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: AppColors.lightOnBackground),
    displaySmall: _baseTextStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.lightOnBackground),
    headlineLarge: _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.lightOnBackground),
    headlineMedium: _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.lightOnBackground),
    headlineSmall: _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.lightOnBackground),
    titleLarge: _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.lightOnBackground),
    titleMedium: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.lightOnBackground),
    titleSmall: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.lightOnBackground),
    bodyLarge: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
        color: AppColors.lightOnBackground),
    bodyMedium: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
        color: AppColors.lightOnBackground),
    bodySmall: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
        color: AppColors.lightOnBackground),
    labelLarge: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: AppColors.lightOnPrimary), // Example: Button text
    labelMedium: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.lightOnBackground),
    labelSmall: _baseTextStyle.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.5,
        color: AppColors.lightOnBackground),
  );

  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: lightTextTheme.displayLarge
        ?.copyWith(color: AppColors.darkOnBackground),
    displayMedium: lightTextTheme.displayMedium
        ?.copyWith(color: AppColors.darkOnBackground),
    displaySmall: lightTextTheme.displaySmall
        ?.copyWith(color: AppColors.darkOnBackground),
    headlineLarge: lightTextTheme.headlineLarge
        ?.copyWith(color: AppColors.darkOnBackground),
    headlineMedium: lightTextTheme.headlineMedium
        ?.copyWith(color: AppColors.darkOnBackground),
    headlineSmall: lightTextTheme.headlineSmall
        ?.copyWith(color: AppColors.darkOnBackground),
    titleLarge:
        lightTextTheme.titleLarge?.copyWith(color: AppColors.darkOnBackground),
    titleMedium:
        lightTextTheme.titleMedium?.copyWith(color: AppColors.darkOnBackground),
    titleSmall:
        lightTextTheme.titleSmall?.copyWith(color: AppColors.darkOnBackground),
    bodyLarge:
        lightTextTheme.bodyLarge?.copyWith(color: AppColors.darkOnBackground),
    bodyMedium:
        lightTextTheme.bodyMedium?.copyWith(color: AppColors.darkOnBackground),
    bodySmall:
        lightTextTheme.bodySmall?.copyWith(color: AppColors.darkOnBackground),
    labelLarge: lightTextTheme.labelLarge
        ?.copyWith(color: AppColors.darkOnPrimary), // Example: Button text
    labelMedium:
        lightTextTheme.labelMedium?.copyWith(color: AppColors.darkOnBackground),
    labelSmall:
        lightTextTheme.labelSmall?.copyWith(color: AppColors.darkOnBackground),
  );
}
