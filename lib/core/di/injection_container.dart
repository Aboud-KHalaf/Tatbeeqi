// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/theme/data/datasources/theme_local_data_source.dart';
import '../../../features/theme/data/repositories/theme_repository_impl.dart';
import '../../features/theme/domain/usecases/get_theme_mode_usecase.dart';
import '../../features/theme/domain/usecases/set_theme_mode_usecase.dart';
import '../../features/theme/domain/repositories/theme_repository.dart';
import '../../features/theme/presentation/manager/theme_cubit.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // Features - Theme
  // Bloc / Cubit
  sl.registerFactory(
    // Register factory for Cubit (new instance each time)
    () => ThemeCubit(
      getThemeModeUseCase: sl<GetThemeModeUseCase>(),
      setThemeModeUseCase: sl<SetThemeModeUseCase>(),
      // Optionally load initial theme here if needed, but loading via method is cleaner
      // initialTheme: sl<SharedPreferences>().getString(AppConstants.themeKey) ... // Complex initial load here is discouraged
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetThemeModeUseCase(sl<ThemeRepository>()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl<ThemeRepository>()));

  // Repository
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl<ThemeLocalDataSource>()),
  );

  // Data sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core / External
  // Register SharedPreferences as a singleton instance
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // You would register other dependencies (like Dio for network, etc.) here
}
