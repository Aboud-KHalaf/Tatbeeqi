import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class GetToDosUseCase implements UseCase<List<ToDoEntity>, NoParams> {
  final ToDoRepository repository;

  GetToDosUseCase(this.repository);

  @override
  Future<Either<Failure, List<ToDoEntity>>> call([NoParams? params]) async {
    return await repository.getToDos();
  }
}