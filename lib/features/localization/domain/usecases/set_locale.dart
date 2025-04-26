import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/localization/domain/repositories/locale_repository.dart';

class SetLocaleUseCase implements UseCase<Unit, Locale> {
  final LocaleRepository repository;

  SetLocaleUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Locale locale) async {
    return await repository.saveLocale(locale);
  }
}