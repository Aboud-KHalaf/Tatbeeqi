import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/theme_repository.dart';

class GetThemeModeUseCase extends UseCase<ThemeMode, NoParams> {
  final ThemeRepository repository;

  GetThemeModeUseCase(this.repository);

  @override
  Future<Either<Failure, ThemeMode>> call([NoParams? params]) async {
    return await repository.getThemeMode();
  }
}
