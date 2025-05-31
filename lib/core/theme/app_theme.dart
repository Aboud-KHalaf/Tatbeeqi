import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

// Defines the ThemeData for light and dark modes.
class AppTheme {
  AppTheme._(); // Private constructor

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        primaryContainer:
            AppColors.lightPrimaryVariant, // Often used for containers
        secondary: AppColors.lightSecondary,
        secondaryContainer: AppColors.lightSecondaryVariant,
        surface: AppColors.lightSurface,
        error: AppColors.lightError,
        onPrimary: AppColors.lightOnPrimary,
        onSecondary: AppColors.lightOnSecondary,
        onSurface: AppColors.lightOnSurface,
        onError: AppColors.lightOnError,
      ),
      textTheme: AppTextStyles.lightTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 0, // Example customization
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightOnPrimary, // Title/icon color
        titleTextStyle: AppTextStyles.lightTextTheme.titleLarge
            ?.copyWith(color: AppColors.lightOnPrimary),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.lightPrimary,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: AppColors.lightOnPrimary,
          textStyle: AppTextStyles.lightTextTheme.labelLarge,
        ),
      ),
      // Add other theme properties like inputDecorationTheme, cardTheme etc.
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        primaryContainer: AppColors.darkPrimaryVariant,
        secondary: AppColors.darkSecondary,
        // secondaryContainer: AppColors.darkSecondaryVariant, // Often same as secondary in dark
        surface: AppColors.darkSurface,
        error: AppColors.darkError,
        onPrimary: AppColors.darkOnPrimary,
        onSecondary: AppColors.darkOnSecondary,
        onSurface: AppColors.darkOnSurface,
        onError: AppColors.darkOnError,
      ),
      textTheme: AppTextStyles.darkTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkOnSurface,
        titleTextStyle: AppTextStyles.darkTextTheme.titleLarge
            ?.copyWith(color: AppColors.darkOnSurface),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.darkPrimary,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkOnPrimary,
          textStyle: AppTextStyles.darkTextTheme.labelLarge,
        ),
      ),
      // Add other theme properties
    );
  }
}
