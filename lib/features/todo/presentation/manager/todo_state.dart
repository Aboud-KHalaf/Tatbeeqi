part of 'todo_cubit.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object> get props => [];
}

class ToDoInitialState extends ToDoState {}

class ToDoLoadingState extends ToDoState {}

class ToDoLoadedState extends ToDoState {
  final List<ToDoEntity> todos;

  const ToDoLoadedState(this.todos);

  @override
  List<Object> get props => [todos];
}

class ToDoErrorState extends ToDoState {
  final String message;

  const ToDoErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ToDoActionSuccessState extends ToDoState {
  final String? message; // Optional success message
  const ToDoActionSuccessState({this.message});
  @override
  List<Object> get props => [message ?? ''];
}

class ToDoActionFailureState extends ToDoState {
  final String message;
  const ToDoActionFailureState(this.message);
  @override
  List<Object> get props => [message];
}
