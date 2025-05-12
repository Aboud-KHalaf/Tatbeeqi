import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/manager/todo_cubit.dart';

class ToDoCheckBoxWidget extends StatelessWidget {
  const ToDoCheckBoxWidget({
    super.key,
    required this.task,
  });

  final ToDoEntity task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;
    return Checkbox(
      value: task.isCompleted,
      onChanged: (bool? value) {
        BlocProvider.of<ToDoCubit>(context).toggleCompletion(task.id, !value!);
      },
      activeColor: colorScheme.primary,
      checkColor: colorScheme.onPrimary,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(
        color: task.isCompleted
            ? colorScheme.primary
            : colorScheme.outline.withOpacity(0.7),
        width: 1.5,
      ),
    );
  }
}
