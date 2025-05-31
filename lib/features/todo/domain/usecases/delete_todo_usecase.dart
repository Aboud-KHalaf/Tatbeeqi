import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class DeleteToDoUseCase implements UseCase<Unit, String> {
  final ToDoRepository repository;

  DeleteToDoUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteToDo(id);
  }
}
