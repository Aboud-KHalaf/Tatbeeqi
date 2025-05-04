import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:tatbeeqi/features/todo/data/models/todo_model.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final ToDoLocalDataSource localDataSource;

  ToDoRepositoryImpl({required this.localDataSource});

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
  Future<Either<Failure, Unit>> deleteToDo(int id) async {
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
  Future<Either<Failure, ToDoEntity>> getToDoById(int id) async {
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
      int id, bool isCompleted) async {
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
      if (todo.id == null) {
        return const Left(
            InvalidInputFailure('ToDo ID cannot be null for update.'));
      }
      final todoModel = ToDoModel.fromEntity(todo);
      await localDataSource.updateToDo(todoModel);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
