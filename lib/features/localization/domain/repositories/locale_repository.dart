import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';

abstract class LocaleRepository {
  /// Gets the currently saved [Locale].
  /// Returns [Failure] if an error occurs.
  Future<Either<Failure, Locale>> getSavedLocale();

  /// Saves the selected [Locale].
  /// Returns [Failure] if an error occurs.
  Future<Either<Failure, Unit>> saveLocale(Locale locale);
}
