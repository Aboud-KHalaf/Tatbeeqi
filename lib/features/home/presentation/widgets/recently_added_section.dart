import 'package:flutter/material.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

// Dummy model
class RecentItem {
  final String title;
  final String type; // e.g., 'PDF', 'Video'
  final IconData icon;

  RecentItem({required this.title, required this.type, required this.icon});
}

class RecentlyAddedSection extends StatelessWidget {
  const RecentlyAddedSection({super.key});

  // Replace with actual data
  List<RecentItem> _getRecentItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      RecentItem(
          title: l10n.homeAdvancedSoftwareEngineering,
          type: 'PDF',
          icon: Icons.picture_as_pdf_outlined),
      // Add more items
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final recentItems = _getRecentItems(context);

    if (recentItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final item = recentItems.first;

    return Card(
      elevation: 2.0,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          // TODO: Implement action (e.g., open PDF)
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.type,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
