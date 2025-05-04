import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoDueDateSelectorWidget extends StatelessWidget {
  final DateTime? selectedDueDate;
  final VoidCallback onSelectDate;
  final VoidCallback onClearDate;

  const TodoDueDateSelectorWidget({
    super.key,
    this.selectedDueDate,
    required this.onSelectDate,
    required this.onClearDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onSelectDate,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(12.0),
          color: theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                selectedDueDate == null
                    ? 'Set Due Date (Optional)' // Consider using AppLocalizations here
                    : 'Due: ${DateFormat('MMM dd, yyyy - HH:mm').format(selectedDueDate!)}',
                style: TextStyle(
                  color: selectedDueDate == null
                      ? theme.colorScheme.onSurface.withOpacity(0.7)
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
            if (selectedDueDate != null)
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: theme.colorScheme.error,
                  size: 20,
                ),
                onPressed: onClearDate,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}
