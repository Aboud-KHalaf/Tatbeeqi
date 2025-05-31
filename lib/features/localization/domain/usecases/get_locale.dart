import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/localization/domain/repositories/locale_repository.dart';

class GetLocaleUseCase implements UseCase<Locale, NoParams> {
  final LocaleRepository repository;

  GetLocaleUseCase(this.repository);

  @override
  Future<Either<Failure, Locale>> call([NoParams? params]) async {
    return await repository.getSavedLocale();
  }
}
