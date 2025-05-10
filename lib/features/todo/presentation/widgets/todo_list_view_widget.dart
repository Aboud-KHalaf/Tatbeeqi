import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/utils/app_methods.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/manager/todo_cubit.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_list_item_widget.dart';

class ToDoListViewWidget extends StatelessWidget {
  const ToDoListViewWidget({
    super.key,
    required this.todos,
  });

  final List<ToDoEntity> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TodoListItem(
            todo: todo,
            onToggleCompletion: (isCompleted) {
              context.read<ToDoCubit>().toggleCompletion(
                    todo.id!,
                    !isCompleted,
                  );
            },
            onEdit: () {
              showAddEditTodoBottomSheet(context, todo: todo);
            },
            onDelete: () {
              context.read<ToDoCubit>().deleteToDo(todo.id!);
            },
          ),
        );
      },
    );
  }
}
