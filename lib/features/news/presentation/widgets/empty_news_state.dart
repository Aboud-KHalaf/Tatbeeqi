import 'package:flutter/material.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class EmptyNewsState extends StatelessWidget {
  const EmptyNewsState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.newspaper_rounded,
                size: 48, color: colorScheme.outline.withOpacity(0.7)),
            const SizedBox(height: 12),
            Text(l10n.newsNoNewsAvailable,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.outline,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 4),
            Text(l10n.newsCheckBackLater,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline.withOpacity(0.7),
                )),
          ],
        ),
      ),
    );
  }
}
