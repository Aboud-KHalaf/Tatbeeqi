// lib/features/theme/data/repositories/theme_repository_impl.dart
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart'; // Import dartz

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart'; // Import failures
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() async {
    try {
      final localThemeMode = await localDataSource.getLastThemeMode();
      // If successful, return Right side of Either
      return Right(localThemeMode);
    } on CacheException catch (e) {
      // If CacheException is caught, return Left side with CacheFailure
      // We'll return system default in the Cubit if this failure occurs.
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      // Catch any other unexpected exception
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setThemeMode(ThemeMode mode) async {
    try {
      await localDataSource.cacheThemeMode(mode);
      // If successful, return Right side with `unit` (from dartz) for void
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      // Catch any other unexpected exception during save
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
