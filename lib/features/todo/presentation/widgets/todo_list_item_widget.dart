import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tatbeeqi/core/utils/app_functions.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class TodoListItem extends StatelessWidget {
  final ToDoEntity todo;
  final Function(bool) onToggleCompletion;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onToggleCompletion,
    required this.onEdit,
    required this.onDelete,
  });

  String _getImportanceText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (todo.importance) {
      case ToDoImportance.high:
        return l10n.todoImportanceHigh;
      case ToDoImportance.medium:
        return l10n.todoImportanceMedium;
      case ToDoImportance.low:
        return l10n.todoImportanceLow;
    }
  }

  String _formatDueDate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (todo.dueDate == null) return l10n.todoNoDueDate;
    return DateFormat('MMM dd, yyyy - HH:mm').format(todo.dueDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('todo_${todo.id}'),
      background: _buildDeleteBackground(),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _showDeleteConfirmation(context);
        }
        return false;
      },
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onDoubleTap: onEdit,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        todo.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                    ),
                    Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        onToggleCompletion(value ?? true);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ],
                ),
                if (todo.description.isNotEmpty) ...[
                  const SizedBox(height: 8.0),
                  Text(
                    todo.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                ],
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: getColorByImportance(todo.importance),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        _getImportanceText(context),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    if (todo.dueDate != null) ...[
                      const Icon(Icons.access_time, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        _formatDueDate(context),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: todo.dueDate!.isBefore(DateTime.now()) &&
                                  !todo.isCompleted
                              ? Colors.red
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(12.0),
      ),
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 20.0, top: 15, bottom: 15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 8),
          Icon(Icons.delete, color: Colors.red),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(l10n.todoConfirmDelete),
              content: Text(l10n.todoDeleteConfirmation),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(l10n.todoCancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    l10n.todoDelete,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
