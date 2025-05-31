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
import 'package:tatbeeqi/features/todo/domain/usecases/update_todos_order_usecase.dart';

part 'todo_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final GetToDosUseCase _getToDosUseCase;
  final AddToDoUseCase _addToDoUseCase;
  final UpdateToDoUseCase _updateToDoUseCase;
  final DeleteToDoUseCase _deleteToDoUseCase;
  final ToggleToDoCompletionUseCase _toggleToDoCompletionUseCase;
  final UpdateTodosOrderUseCase _updateTodosOrderUseCase;

  ToDoCubit({
    required GetToDosUseCase getToDosUseCase,
    required AddToDoUseCase addToDoUseCase,
    required UpdateToDoUseCase updateToDoUseCase,
    required DeleteToDoUseCase deleteToDoUseCase,
    required ToggleToDoCompletionUseCase toggleToDoCompletionUseCase,
    required UpdateTodosOrderUseCase updateTodosOrderUseCase,
  })  : _getToDosUseCase = getToDosUseCase,
        _addToDoUseCase = addToDoUseCase,
        _updateToDoUseCase = updateToDoUseCase,
        _deleteToDoUseCase = deleteToDoUseCase,
        _toggleToDoCompletionUseCase = toggleToDoCompletionUseCase,
        _updateTodosOrderUseCase = updateTodosOrderUseCase,
        super(ToDoInitialState());

  List<ToDoEntity> _todos = [];

  Future<void> fetchToDos() async {
    emit(ToDoLoadingState());
    final failureOrToDos = await _getToDosUseCase(NoParams());
    failureOrToDos.fold(
      (failure) => emit(ToDoErrorState(failure.message)),
      (todos) {
        _todos = List<ToDoEntity>.from(todos);
        _todos.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        emit(ToDoLoadedState(_todos));
      },
    );
  }

  Future<void> addToDo(ToDoEntity todo) async {
    final newOrderIndex = _todos.isNotEmpty
        ? _todos.map((t) => t.orderIndex).reduce((a, b) => a > b ? a : b) + 1
        : 0;
    final todoWithOrder = todo.copyWith(orderIndex: newOrderIndex);

    final result = await _addToDoUseCase(todoWithOrder);
    result.fold(
      (failure) {
        AppLogger.error(failure.message);
        emit(ToDoActionFailureState(failure.message));
        if (state is ToDoLoadedState) emit(ToDoLoadedState(List.from(_todos)));
      },
      (_) {
        _todos = [..._todos, todoWithOrder];
        _todos.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        emit(const ToDoActionSuccessState(message: 'ToDo added successfully!'));
        emit(ToDoLoadedState(List.from(_todos)));
      },
    );
  }

  Future<void> updateToDo(ToDoEntity updatedTodo) async {
    final result = await _updateToDoUseCase(updatedTodo);
    result.fold(
      (failure) => emit(ToDoActionFailureState(failure.message)),
      (_) {
        final int index =
            _todos.indexWhere((todo) => todo.id == updatedTodo.id);

        if (index != -1) {
          _todos = _todos.map((todo) {
            return todo.id == updatedTodo.id ? updatedTodo : todo;
          }).toList();

          emit(const ToDoActionSuccessState(
              message: 'ToDo updated successfully!'));
          emit(ToDoLoadedState(_todos));
        } else {
          emit(const ToDoActionFailureState("ToDo not found to update."));
        }
      },
    );
  }

  Future<void> deleteToDo(String id) async {
    final result = await _deleteToDoUseCase(id);
    result.fold(
      (failure) => emit(ToDoActionFailureState(failure.message)),
      (_) {
        _todos = _todos.where((todo) => todo.id != id).toList();
        emit(const ToDoActionSuccessState(
            message: 'ToDo deleted successfully!'));
        emit(ToDoLoadedState(_todos));
      },
    );
  }

  Future<void> toggleCompletion(String id, bool currentStatus) async {
    final result = await _toggleToDoCompletionUseCase(
      ToggleToDoParams(id: id, isCompleted: !currentStatus),
    );
    result.fold(
      (failure) => emit(ToDoActionFailureState(failure.message)),
      (_) {
        _todos = _todos.map((todo) {
          return todo.id == id
              ? todo.copyWith(isCompleted: !currentStatus)
              : todo;
        }).toList();
        emit(ToDoLoadedState(_todos));
      },
    );
  }

  Future<void> reorderToDos(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ToDoEntity item = _todos.removeAt(oldIndex);
    _todos.insert(newIndex, item);

    final List<ToDoEntity> updatedTodosWithOrder = [];
    for (int i = 0; i < _todos.length; i++) {
      updatedTodosWithOrder.add(_todos[i].copyWith(orderIndex: i));
    }
    _todos = List.from(updatedTodosWithOrder);

    emit(ToDoLoadedState(List.from(_todos)));

    final result = await _updateTodosOrderUseCase(updatedTodosWithOrder);
    result.fold(
      (failure) {
        emit(ToDoActionFailureState(failure.message));
      },
      (_) {},
    );
  }
}
