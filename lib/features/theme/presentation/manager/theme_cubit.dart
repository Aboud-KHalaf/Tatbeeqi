import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_theme_mode_usecase.dart';
import '../../domain/usecases/set_theme_mode_usecase.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final GetThemeModeUseCase _getThemeModeUseCase;
  final SetThemeModeUseCase _setThemeModeUseCase;

  ThemeCubit({
    required GetThemeModeUseCase getThemeModeUseCase,
    required SetThemeModeUseCase setThemeModeUseCase,
    // Initial theme defaults to system, loadThemeMode will overwrite if successful
  })  : _getThemeModeUseCase = getThemeModeUseCase,
        _setThemeModeUseCase = setThemeModeUseCase,
        super(ThemeMode.system); // Start with system theme

  /// Loads the saved theme mode from storage and emits it.
  /// Emits [ThemeMode.system] if loading fails.
  Future<void> loadThemeMode() async {
    //  using Base UseCase with NoParams:
    final result = await _getThemeModeUseCase(NoParams());

    // Use fold to handle Either<Failure, ThemeMode>
    result.fold(
      (failure) {
        // On failure, emit the default system theme and log the error
        print('Error loading theme: ${_mapFailureToMessage(failure)}');
        emit(ThemeMode.system);
      },
      (themeMode) {
        // On success, emit the loaded theme mode
        emit(themeMode);
      },
    );
  }

  /// Sets the theme mode, persists it, and emits the new state.
  /// If saving fails, the state is not changed (or you could emit an error state).
  Future<void> setThemeMode(ThemeMode mode) async {
    final previousState = state; // Keep track of the current state
    emit(mode); // Optimistically update the UI

    //  using Base UseCase:
    final result = await _setThemeModeUseCase(mode);

    // Use fold to handle Either<Failure, void> for the save operation
    result.fold(
      (failure) {
        // If saving failed, revert to the previous state and log error
        print('Error setting theme: ${_mapFailureToMessage(failure)}');
        emit(previousState); // Revert optimistic update
        // Optionally: emit a specific error state or show a snackbar
      },
      (_) {
        // On success (Right side contains unit), the state is already emitted optimistically.
        // No further action needed here.
      },
    );
  }

  // Helper function to convert Failure types to readable messages (optional)
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure _:
        // Access the message property if you defined it
        return (failure as CacheFailure).message.isNotEmpty
            ? failure.message
            : 'Cache Error';
      case GeneralFailure _:
        return (failure as GeneralFailure).message.isNotEmpty
            ? failure.message
            : 'An unexpected error occurred';
      default:
        return 'Unexpected error';
    }
  }
}
