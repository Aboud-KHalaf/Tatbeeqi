import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/constants/constants.dart';
import 'package:tatbeeqi/features/localization/domain/usecases/get_locale.dart';
import 'package:tatbeeqi/features/localization/domain/usecases/set_locale.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetLocaleUseCase _getLocaleUseCase;
  final SetLocaleUseCase _setLocaleUseCase;

  LocaleCubit({
    required GetLocaleUseCase getLocaleUseCase,
    required SetLocaleUseCase setLocaleUseCase,
  })  : _getLocaleUseCase = getLocaleUseCase,
        _setLocaleUseCase = setLocaleUseCase,
        super(const LocaleInitial());

  Future<void> getSavedLocale() async {
    final result = await _getLocaleUseCase();
    result.fold(
      (failure) {
        emit(LocaleError(
            const Locale(AppConstants.defaultLocale), failure.toString()));
      },
      (locale) => emit(LocaleLoaded(locale)),
    );
  }

  Future<void> setLocale(Locale locale) async {
    final result = await _setLocaleUseCase(locale);
    result.fold(
      (failure) {
        emit(LocaleError(state.locale, failure.toString()));
      },
      (_) => emit(LocaleLoaded(locale)),
    );
  }
}
