import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/theme_repository.dart';
import '../../../../core/usecases/usecase.dart';

class SetThemeModeUseCase extends UseCase<void, ThemeMode> {
  final ThemeRepository repository;

  SetThemeModeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([ThemeMode? params]) async {
    return await repository.setThemeMode(params!);
  }
}
