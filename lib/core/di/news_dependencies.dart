import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tatbeeqi/features/news/data/datasources/news_remote_data_source.dart';
import 'package:tatbeeqi/features/news/data/repositories/news_repository_impl.dart';
import 'package:tatbeeqi/features/news/domain/repositories/news_repository.dart';
import 'package:tatbeeqi/features/news/domain/usecases/get_news_items_usecase.dart';
import 'package:tatbeeqi/features/news/presentation/manager/news_cubit.dart';

void initNewsDependencies(GetIt sl) {
  // --- Notifications Feature ---
  // Manager (Cubit)
  sl.registerFactory(() => NewsCubit(
        getNewsItemsUsecase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetNewsItemsUsecase(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(remoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(supabaseClient: sl<SupabaseClient>()));
}
