import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';

abstract class LocaleRepository {
  Future<Either<Failure, Locale>> getSavedLocale();

  Future<Either<Failure, Unit>> saveLocale(Locale locale);
}
