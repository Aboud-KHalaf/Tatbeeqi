import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/importance_option_widget.dart';

class TodoImportanceSelector extends StatelessWidget {
  final ToDoImportance selectedImportance;
  final Function(ToDoImportance) onImportanceChanged;

  const TodoImportanceSelector({
    super.key,
    required this.selectedImportance,
    required this.onImportanceChanged,
  });
  Color _getImportanceColor(ToDoImportance importance) {
    switch (importance) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ImportanceOptionWidget(
              label: 'Low',
              color: _getImportanceColor(ToDoImportance.low),
              isSelected: selectedImportance == ToDoImportance.low,
              onTap: () => onImportanceChanged(ToDoImportance.low),
            ),
            const SizedBox(width: 12.0),
            ImportanceOptionWidget(
              label: 'Medium',
              color: _getImportanceColor(ToDoImportance.medium),
              isSelected: selectedImportance == ToDoImportance.medium,
              onTap: () => onImportanceChanged(ToDoImportance.medium),
            ),
            const SizedBox(width: 12.0),
            ImportanceOptionWidget(
              label: 'High',
              color: _getImportanceColor(ToDoImportance.high),
              isSelected: selectedImportance == ToDoImportance.high,
              onTap: () => onImportanceChanged(ToDoImportance.high),
            ),
          ],
        ),
      ],
    );
  }
}
