import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tatbeeqi/core/services/database_service.dart';
import 'package:tatbeeqi/features/courses/data/datasources/course_local_data_source.dart';
import 'package:tatbeeqi/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:tatbeeqi/features/courses/data/repositories/course_repository_impl.dart';
import 'package:tatbeeqi/features/courses/domain/repositories/course_repository.dart';
import 'package:tatbeeqi/features/courses/domain/usecases/get_all_courses_for_retake_usecase.dart';
import 'package:tatbeeqi/features/courses/domain/usecases/get_courses_by_study_year_and_department_id_usecase.dart';
import 'package:tatbeeqi/features/courses/domain/usecases/save_selected_retake_courses_usecase.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/fetch_courses_cubit/fetch_courses_cubit.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/retake_courses_cubit/retake_courses_cubit.dart';

void initCoursesDependencies(GetIt sl) {
  // --- Courses Feature ---

  // Manager (Cubit)
  sl.registerFactory(() => FetchCoursesCubit(
        getCoursesByStudyYearUseCase: sl(),
      ));
  sl.registerFactory(() => RetakeCoursesCubit(
        getAllCoursesForRetakeUsecase: sl(),
        saveSelectedRetakeCoursesUseCase: sl(), 
      ));

  // Use Cases
  sl.registerLazySingleton(
      () => GetCoursesByStudyYearAndDepartmentIdUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCoursesForRetakeUsecase(sl()));
   sl.registerLazySingleton(() => SaveSelectedRetakeCoursesUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(supabaseClient: sl<SupabaseClient>()));

  sl.registerLazySingleton<CourseLocalDataSource>(
      () => CourseLocalDataSourceImpl(
            databaseService: sl<DatabaseService>(),
          ));
}
