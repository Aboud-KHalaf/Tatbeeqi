import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoEntity>>> getToDos();
  Future<Either<Failure, ToDoEntity>> getToDoById(String id);
  Future<Either<Failure, Unit>> addToDo(ToDoEntity todo);
  Future<Either<Failure, Unit>> updateToDo(ToDoEntity todo);
  Future<Either<Failure, Unit>> deleteToDo(String id);
  Future<Either<Failure, Unit>> toggleToDoCompletion(
      String id, bool isCompleted);
  Future<Either<Failure, Unit>> updateTodosOrder(List<ToDoEntity> todos); // Add this
}
