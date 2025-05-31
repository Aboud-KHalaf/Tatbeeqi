import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class UpdateToDoUseCase implements UseCase<Unit, ToDoEntity> {
  final ToDoRepository repository;

  UpdateToDoUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ToDoEntity todo) async {
    return await repository.updateToDo(todo);
  }
}
