import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodosOrderUseCase implements UseCase<Unit, List<ToDoEntity>> {
  final ToDoRepository repository;

  UpdateTodosOrderUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(List<ToDoEntity> todos) async {
    return await repository.updateTodosOrder(todos);
  }
}