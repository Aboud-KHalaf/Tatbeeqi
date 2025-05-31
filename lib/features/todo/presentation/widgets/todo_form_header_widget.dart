import 'package:flutter/material.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class TodoFormHeaderWidget extends StatelessWidget {
  final bool isEditing;

  const TodoFormHeaderWidget({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Text(
      isEditing ? l10n.todoEditTask : l10n.todoAddNewTask,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}
