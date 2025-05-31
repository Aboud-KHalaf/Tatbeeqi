import 'dart:ui';

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
    return ReorderableListView.builder(
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double animValue =
                Curves.easeInOut.transform(animation.value);
            final double shadowBlurRadius = lerpDouble(5, 8, animValue)!;
            final double scale = lerpDouble(1, 1.05, animValue)!;

            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(.3),
                      blurRadius: shadowBlurRadius,
                    ),
                  ],
                ),
                child: child,
              ),
            );
          },
          child: child,
        );
      },
      itemCount: todos.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Padding(
          key: ValueKey(todo.id),
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TodoListItem(
            todo: todo,
            onToggleCompletion: (isCompleted) {
              context.read<ToDoCubit>().toggleCompletion(
                    todo.id,
                    todo.isCompleted,
                  );
            },
            onEdit: () {
              showAddEditTodoBottomSheet(context, todo: todo);
            },
            onDelete: () {
              context.read<ToDoCubit>().deleteToDo(todo.id);
            },
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        context.read<ToDoCubit>().reorderToDos(oldIndex, newIndex);
      },
    );
  }
}
