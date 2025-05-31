import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:tatbeeqi/features/todo/data/models/todo_model.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final ToDoLocalDataSource localDataSource;
  // final NetworkInfo networkInfo; // If you have remote data source

  ToDoRepositoryImpl({
    required this.localDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addToDo(ToDoEntity todo) async {
    try {
      final todoModel = ToDoModel.fromEntity(todo);
      await localDataSource.addToDo(todoModel);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteToDo(String id) async {
    try {
      await localDataSource.deleteToDo(id);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ToDoEntity>> getToDoById(String id) async {
    try {
      final todoModel = await localDataSource.getToDoById(id);
      return Right(todoModel); // ToDoModel extends ToDoEntity
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ToDoEntity>>> getToDos() async {
    try {
      final todoModels = await localDataSource.getToDos();
      // Since ToDoModel extends ToDoEntity, the list is already compatible.
      return Right(todoModels);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleToDoCompletion(
      String id, bool isCompleted) async {
    try {
      await localDataSource.toggleToDoCompletion(id, isCompleted);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateToDo(ToDoEntity todo) async {
    try {
      final todoModel = ToDoModel.fromEntity(todo);
      await localDataSource.updateToDo(todoModel);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTodosOrder(List<ToDoEntity> todos) async {
    try {
      final todoModels = todos.map((e) => ToDoModel.fromEntity(e)).toList();
      await localDataSource.updateTodosOrder(todoModels);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
