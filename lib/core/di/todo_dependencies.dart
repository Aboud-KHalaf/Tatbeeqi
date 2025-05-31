import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/core/services/database_service.dart';
import 'package:tatbeeqi/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:tatbeeqi/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/toggle_todo_completion_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/update_todos_order_usecase.dart';
import 'package:tatbeeqi/features/todo/presentation/manager/todo_cubit.dart';

void initTDoDependencies(GetIt sl) {
  sl.registerFactory(() => ToDoCubit(
        getToDosUseCase: sl(),
        addToDoUseCase: sl(),
        updateToDoUseCase: sl(),
        deleteToDoUseCase: sl(),
        toggleToDoCompletionUseCase: sl(),
        updateTodosOrderUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetToDosUseCase(sl()));
  sl.registerLazySingleton(() => AddToDoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateToDoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteToDoUseCase(sl()));
  sl.registerLazySingleton(() => ToggleToDoCompletionUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTodosOrderUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ToDoRepository>(
      () => ToDoRepositoryImpl(localDataSource: sl()));

  // Data Sources
  // Register ToDoLocalDataSourceImpl and inject DatabaseService
  sl.registerLazySingleton<ToDoLocalDataSource>(() => ToDoLocalDataSourceImpl(
      databaseService: sl<DatabaseService>())); // Inject service
}
