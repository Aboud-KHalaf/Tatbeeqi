import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/localization/data/datasources/locale_local_data_source.dart';
import 'package:tatbeeqi/features/localization/domain/repositories/locale_repository.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleLocalDataSource localDataSource;

  LocaleRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Locale>> getSavedLocale() async {
    final localeCode = await localDataSource.getLastLocaleCode();
    return Right(Locale(localeCode));
  }

  @override
  Future<Either<Failure, Unit>> saveLocale(Locale locale) async {
    try {
      await localDataSource.cacheLocaleCode(locale.languageCode);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(CacheFailure('Failed to save locale: ${e.toString()}'));
    }
  }
}
