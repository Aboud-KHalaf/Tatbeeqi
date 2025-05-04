import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';

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

  Color _getImportanceColor() {
    switch (todo.importance) {
      case ToDoImportance.high:
        return Colors.red.shade200;
      case ToDoImportance.medium:
        return Colors.orange.shade200;
      case ToDoImportance.low:
        return Colors.green.shade200;
      default:
        return Colors.cyan.shade200;
    }
  }

  String _getImportanceText() {
    switch (todo.importance) {
      case ToDoImportance.high:
        return 'High';
      case ToDoImportance.medium:
        return 'Medium';
      case ToDoImportance.low:
      default:
        return 'Low';
    }
  }

  String _formatDueDate() {
    if (todo.dueDate == null) return 'No due date';
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
          onLongPress: onEdit,
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
                        color: _getImportanceColor(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        _getImportanceText(),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    if (todo.dueDate != null) ...[
                      const Icon(Icons.access_time, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        _formatDueDate(),
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
      padding: const EdgeInsets.only(right: 20.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.delete, color: Colors.red),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content: const Text('Are you sure you want to delete this item?'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
