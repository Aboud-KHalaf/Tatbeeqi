import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/core/utils/app_logger.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/toggle_todo_completion_usecase.dart';
import 'package:tatbeeqi/features/todo/domain/usecases/update_todo_usecase.dart';

part 'todo_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final GetToDosUseCase _getToDosUseCase;
  final AddToDoUseCase _addToDoUseCase;
  final UpdateToDoUseCase _updateToDoUseCase;
  final DeleteToDoUseCase _deleteToDoUseCase;
  final ToggleToDoCompletionUseCase _toggleToDoCompletionUseCase;

  ToDoCubit({
    required GetToDosUseCase getToDosUseCase,
    required AddToDoUseCase addToDoUseCase,
    required UpdateToDoUseCase updateToDoUseCase,
    required DeleteToDoUseCase deleteToDoUseCase,
    required ToggleToDoCompletionUseCase toggleToDoCompletionUseCase,
  })  : _getToDosUseCase = getToDosUseCase,
        _addToDoUseCase = addToDoUseCase,
        _updateToDoUseCase = updateToDoUseCase,
        _deleteToDoUseCase = deleteToDoUseCase,
        _toggleToDoCompletionUseCase = toggleToDoCompletionUseCase,
        super(ToDoInitialState());

  Future<void> fetchToDos() async {
    emit(ToDoLoadingState());
    final failureOrToDos = await _getToDosUseCase(NoParams());
    failureOrToDos.fold(
      (failure) => emit(ToDoErrorState(failure.message)),
      (todos) {
        emit(ToDoLoadedState(todos));
        AppLogger.warning("the state is $state");
      },
    );
  }

  Future<void> addToDo(ToDoEntity todo) async {
    final failureOrSuccess = await _addToDoUseCase(todo);
    failureOrSuccess
        .fold((failure) => emit(ToDoActionFailureState(failure.message)), (_) {
      emit(const ToDoActionSuccessState(message: 'ToDo added successfully!'));
      fetchToDos();
    });
  }

  Future<void> updateToDo(ToDoEntity todo) async {
    final failureOrSuccess = await _updateToDoUseCase(todo);
    failureOrSuccess
        .fold((failure) => emit(ToDoActionFailureState(failure.message)), (_) {
      emit(const ToDoActionSuccessState(message: 'ToDo updated successfully!'));
      fetchToDos();
    });
  }

  Future<void> deleteToDo(int id) async {
    final failureOrSuccess = await _deleteToDoUseCase(id);
    failureOrSuccess
        .fold((failure) => emit(ToDoActionFailureState(failure.message)), (_) {
      emit(const ToDoActionSuccessState(message: 'ToDo deleted successfully!'));
      fetchToDos();
    });
  }

  Future<void> toggleCompletion(int id, bool currentStatus) async {
    final failureOrSuccess = await _toggleToDoCompletionUseCase(
        ToggleToDoParams(id: id, isCompleted: !currentStatus));
    failureOrSuccess
        .fold((failure) => emit(ToDoActionFailureState(failure.message)), (_) {
      fetchToDos();
    });
  }
}
