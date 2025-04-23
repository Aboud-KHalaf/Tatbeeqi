import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:tatbeeqi/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:tatbeeqi/features/theme/domain/repositories/theme_repository.dart';
import 'package:tatbeeqi/features/theme/domain/usecases/get_theme_mode_usecase.dart';
import 'package:tatbeeqi/features/theme/domain/usecases/set_theme_mode_usecase.dart';
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit.dart';

void initThemeDependencies(GetIt sl) {
  // --- Theme Feature ---
  // Manager (Cubit)
  sl.registerFactory(
    () => ThemeCubit(
      getThemeModeUseCase: sl<GetThemeModeUseCase>(),
      setThemeModeUseCase: sl<SetThemeModeUseCase>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(localDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(sharedPreferences: sl()));
}