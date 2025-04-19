import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/localization/domain/usecases/get_locale_usecase.dart';
import 'package:tatbeeqi/features/localization/domain/usecases/set_locale_usecase.dart';
import '../../../../core/constants/constants.dart';
import 'locale_state.dart'; // Adjust import path

class LocaleCubit extends Cubit<LocaleState> {
  final GetLocaleUseCase getLocaleUseCase;
  final SetLocaleUseCase setLocaleUseCase;

  LocaleCubit({
    required this.getLocaleUseCase,
    required this.setLocaleUseCase,
  }) : super(const LocaleInitial()); // Start with initial state

  Future<void> getSavedLocale() async {
    final result = await getLocaleUseCase(NoParams());
    result.fold(
      (failure) {
        // Handle failure - maybe emit error state or just use default
        // Emit error but keep a default locale
        emit(LocaleError(
            const Locale(AppConstants.defaultLocale), failure.toString()));
      },
      (locale) => emit(LocaleLoaded(locale)),
    );
  }

  Future<void> setLocale(Locale locale) async {
    final result = await setLocaleUseCase(locale);
    result.fold(
      (failure) {
        // Handle failure - emit error state but keep the *previous* successful locale
        emit(LocaleError(state.locale, failure.toString()));
      },
      (_) => emit(LocaleLoaded(locale)), // On success, emit the new locale
    );
  }
}
