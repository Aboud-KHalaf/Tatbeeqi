import 'package:flutter/material.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class ToDoNoDataAvaiableWidget extends StatelessWidget {
  const ToDoNoDataAvaiableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        l10n.todoNoDataAvailable,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }
}
