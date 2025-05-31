import 'package:flutter/material.dart';
import 'package:tatbeeqi/core/utils/app_functions.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_check_box_widget.dart';

class ToDayTaskListViewItemWidget extends StatelessWidget {
  const ToDayTaskListViewItemWidget({
    super.key,
    required this.task,
  });

  final ToDoEntity task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            // Add tap handling if needed
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: task.isCompleted
                  ? colorScheme.surfaceContainerHighest.withOpacity(0.2)
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: task.isCompleted
                    ? colorScheme.outline.withOpacity(0.1)
                    : getColorByImportance(task.importance),
                width: 1.2,
              ),
              boxShadow: [
                if (!task.isCompleted)
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: textTheme.bodyLarge?.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: task.isCompleted
                              ? colorScheme.onSurface.withOpacity(0.6)
                              : colorScheme.onSurface,
                          fontWeight: task.isCompleted
                              ? FontWeight.normal
                              : FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (task.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            task.description,
                            style: textTheme.bodyMedium?.copyWith(
                              color: task.isCompleted
                                  ? colorScheme.onSurface.withOpacity(0.4)
                                  : colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ToDoCheckBoxWidget(task: task),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
