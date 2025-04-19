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
      return const Right(unit); // unit signifies success with no data
    } on Exception catch (e) {
      // Catch potential SharedPreferences errors
      return Left(
          CacheFailure(message: 'Failed to save locale: ${e.toString()}'));
    }
  }
}


/*

feat: Implement localization support

Adds multi-language support (en,ar) to the application, allowing users to select their preferred language with persistence.

Implemented using standard Flutter localization (`intl`, `.arb` files) integrated with a Clean Architecture approach for managing the selected locale preference via `LocaleCubit`.
 The user's choice is persisted using `SharedPreferences`, and the UI updates dynamically without an app restart.

Key changes:
- Created `features/localization/` module following Clean Architecture:
  - `LocaleLocalDataSource`: Saves/loads language code via SharedPreferences.
  - `LocaleRepository`: Manages getting/setting the preferred locale (handles default).
  - `GetLocaleUseCase`, `SetLocaleUseCase`: Encapsulated domain logic.
  - `LocaleCubit`: Manages the active `Locale` state.
- Integrated `LocaleCubit` state with `MaterialApp` (`locale`, `localizationsDelegates`, `supportedLocales`).
- Added `l10n.yaml` config and initial `.arb` files (en , ar).
- Used `dartz`/`Either` for error handling in data/domain layers.
- Registered new components in `get_it` dependency injection.



 */
