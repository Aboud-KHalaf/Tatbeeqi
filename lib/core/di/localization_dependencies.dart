import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/features/localization/data/datasources/locale_local_data_source.dart';
import 'package:tatbeeqi/features/localization/data/repositories/locale_repository_impl.dart';
import 'package:tatbeeqi/features/localization/domain/repositories/locale_repository.dart';
import 'package:tatbeeqi/features/localization/domain/usecases/get_locale.dart';
import 'package:tatbeeqi/features/localization/domain/usecases/set_locale.dart';

import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_cubit.dart';

void initLocalizationDependencies(GetIt sl) {
  // --- Localization Feature ---
  // Manager (Cubit)
  sl.registerFactory(
      () => LocaleCubit(getLocaleUseCase: sl(), setLocaleUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetLocaleUseCase(sl()));
  sl.registerLazySingleton(() => SetLocaleUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LocaleRepository>(
      () => LocaleRepositoryImpl(localDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<LocaleLocalDataSource>(
      () => LocaleLocalDataSourceImpl(sharedPreferences: sl()));
}
