import 'package:flutter/material.dart';

// Defines the color palette for the application.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // --- Light Theme Colors ---
  static const Color lightPrimary = Color(0xFF6200EE); // Example Purple
  static const Color lightPrimaryVariant = Color(0xFF3700B3);
  static const Color lightSecondary = Color(0xFF03DAC6); // Example Teal
  static const Color lightSecondaryVariant = Color(0xFF018786);
  static const Color lightBackground = Color(0xFFFFFFFF); // White
  static const Color lightSurface = Color(0xFFFFFFFF); // White
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnPrimary = Color(0xFFFFFFFF); // White text on Purple
  static const Color lightOnSecondary = Color(0xFF000000); // Black text on Teal
  static const Color lightOnBackground = Color(0xFF000000); // Black text on White
  static const Color lightOnSurface = Color(0xFF000000); // Black text on White
  static const Color lightOnError = Color(0xFFFFFFFF); // White text on Red

  // --- Dark Theme Colors ---
  static const Color darkPrimary = Color(0xFFBB86FC); // Example Light Purple
  static const Color darkPrimaryVariant = Color(0xFF3700B3); // Often same as light
  static const Color darkSecondary = Color(0xFF03DAC6); // Example Teal (often same)
  // static const Color darkSecondaryVariant = Color(0xFF03DAC6); // Can be same or adjusted
  static const Color darkBackground = Color(0xFF121212); // Dark Grey
  static const Color darkSurface = Color(0xFF1E1E1E); // Slightly lighter Grey
  static const Color darkError = Color(0xFFCF6679); // Lighter Red
  static const Color darkOnPrimary = Color(0xFF000000); // Black text on Light Purple
  static const Color darkOnSecondary = Color(0xFF000000); // Black text on Teal
  static const Color darkOnBackground = Color(0xFFFFFFFF); // White text on Dark Grey
  static const Color darkOnSurface = Color(0xFFFFFFFF); // White text on Lighter Grey
  static const Color darkOnError = Color(0xFF000000); // Black text on Lighter Red

  // --- Common Colors ---
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFE0E0E0);
  // Add other common colors as needed
}