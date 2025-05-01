import 'package:flutter/material.dart';

/// Defines the color palette for the application.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // --- Light Theme Colors ---
  static const Color lightPrimary = Color(0xFF00BCD4); // Cyan
  static const Color lightPrimaryVariant = Color(0xFF008BA3); // Darker Cyan
  static const Color lightSecondary = Color(0xFF4DD0E1); // Light Cyan
  static const Color lightSecondaryVariant =
      Color(0xFF26C6DA); // Strong Light Cyan
  static const Color lightBackground =
      Color(0xFFFFFFFF); // **Standard White Background**
  static const Color lightSurface = Color(0xFFFFFFFF); // White surface
  static const Color lightError = Color(0xFFEF5350); // Soft Red
  static const Color lightOnPrimary = Color(0xFFFFFFFF); // White text on Cyan
  static const Color lightOnSecondary =
      Color(0xFF000000); // Black text on Light Cyan
  static const Color lightOnBackground = Color(0xFF000000); // Black text
  static const Color lightOnSurface = Color(0xFF000000); // Black text
  static const Color lightOnError = Color(0xFFFFFFFF); // White text on Red

  // --- Dark Theme Colors ---
  static const Color darkPrimary = Color(0xFF00ACC1); // Deep Cyan
  static const Color darkPrimaryVariant = Color(0xFF007C91); // Deeper Cyan
  static const Color darkSecondary = Color(0xFF4DD0E1); // Light Cyan
  static const Color darkBackground =
      Color(0xFF121212); // **Standard Dark Grey Background**
  static const Color darkSurface = Color(0xFF1E1E1E); // Dark Surface
  static const Color darkError = Color(0xFFCF6679); // Light Red
  static const Color darkOnPrimary = Color(0xFF000000); // Black text on Cyan
  static const Color darkOnSecondary =
      Color(0xFF000000); // Black text on Light Cyan
  static const Color darkOnBackground = Color(0xFFFFFFFF); // White text
  static const Color darkOnSurface = Color(0xFFFFFFFF); // White text
  static const Color darkOnError = Color(0xFF000000); // Black text on error

  // --- Common Colors ---
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFB0BEC5); // Light Blue-Grey
}
