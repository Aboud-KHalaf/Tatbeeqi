import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeMode>> getThemeMode();
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode);
}
