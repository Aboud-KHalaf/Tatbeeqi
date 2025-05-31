import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/todo/domain/repositories/todo_repository.dart';

class ToggleToDoCompletionUseCase implements UseCase<Unit, ToggleToDoParams> {
  final ToDoRepository repository;

  ToggleToDoCompletionUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ToggleToDoParams params) async {
    return await repository.toggleToDoCompletion(params.id, params.isCompleted);
  }
}

class ToggleToDoParams extends Equatable {
  final String id;
  final bool isCompleted;

  const ToggleToDoParams({required this.id, required this.isCompleted});

  @override
  List<Object?> get props => [id, isCompleted];
}
