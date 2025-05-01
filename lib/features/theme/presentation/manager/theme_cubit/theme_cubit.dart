import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/theme/app_theme.dart';
import 'package:tatbeeqi/core/utils/app_logger.dart';
import 'package:tatbeeqi/features/theme/domain/usecases/get_theme_mode_usecase.dart';
import 'package:tatbeeqi/features/theme/domain/usecases/set_theme_mode_usecase.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final GetThemeModeUseCase _getThemeModeUseCase;
  final SetThemeModeUseCase _setThemeModeUseCase;

  ThemeCubit({
    required GetThemeModeUseCase getThemeModeUseCase,
    required SetThemeModeUseCase setThemeModeUseCase,
  })  : _getThemeModeUseCase = getThemeModeUseCase,
        _setThemeModeUseCase = setThemeModeUseCase,
        super(AppTheme.lightTheme);

  Future<void> loadTheme() async {
    final result = await _getThemeModeUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Error loading theme preference', failure);
        emit(AppTheme.lightTheme);
      },
      (themeMode) {
        if (themeMode == ThemeMode.dark) {
          emit(AppTheme.darkTheme);
        } else {
          emit(AppTheme.lightTheme);
        }
      },
    );
  }

  Future<void> setTheme(ThemeMode mode) async {
    final ThemeData targetTheme =
        (mode == ThemeMode.dark) ? AppTheme.darkTheme : AppTheme.lightTheme;

    final previousState = state;
    emit(targetTheme);

    final result = await _setThemeModeUseCase(mode);
    result.fold(
      (failure) {
        AppLogger.error('Error setting theme preference', failure);
        emit(previousState);
      },
      (_) {},
    );
  }
}
