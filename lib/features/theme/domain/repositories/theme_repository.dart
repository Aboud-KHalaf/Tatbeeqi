import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class ThemeRepository {
  /// Gets the current theme mode. Returns [Failure] if unsuccessful.
  Future<Either<Failure, ThemeMode>> getThemeMode();

  /// Saves the chosen theme mode. Returns [Failure] if unsuccessful.
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode);
}
