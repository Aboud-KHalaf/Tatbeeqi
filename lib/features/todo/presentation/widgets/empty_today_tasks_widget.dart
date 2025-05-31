import 'package:flutter/material.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class EmptyToDayTasksWidget extends StatelessWidget {
  const EmptyToDayTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.task_alt,
              size: 40,
              color: colorScheme.outline.withOpacity(0.7),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.homeNoTasksForToday,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
