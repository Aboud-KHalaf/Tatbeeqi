import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/importance_option_widget.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.todoImportance,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ImportanceOptionWidget(
              label: l10n.todoImportanceLow,
              color: _getImportanceColor(ToDoImportance.low),
              isSelected: selectedImportance == ToDoImportance.low,
              onTap: () => onImportanceChanged(ToDoImportance.low),
            ),
            const SizedBox(width: 8.0),
            ImportanceOptionWidget(
              label: l10n.todoImportanceMedium,
              color: _getImportanceColor(ToDoImportance.medium),
              isSelected: selectedImportance == ToDoImportance.medium,
              onTap: () => onImportanceChanged(ToDoImportance.medium),
            ),
            const SizedBox(width: 8.0),
            ImportanceOptionWidget(
              label: l10n.todoImportanceHigh,
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
