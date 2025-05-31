import 'package:flutter/material.dart';
import 'package:tatbeeqi/core/widgets/ai_action_button.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // Get screen width to adjust layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: isSmallScreen ? 8.0 : 16.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          l10n.homeGreeting,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                            fontSize: isSmallScreen ? 18 : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.waving_hand_rounded,
                        color: Colors.amber,
                        size: isSmallScreen ? 16 : 20,
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      l10n.homeContinueLearning,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: isSmallScreen ? 10 : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          // Left side (Buttons)
          Row(
            children: [
              const AiActionButton(),
              SizedBox(width: isSmallScreen ? 6 : 10),
              // Notifications Button
              Material(
                borderRadius:
                    BorderRadius.circular(isSmallScreen ? 10.0 : 12.0),
                color: colorScheme.surfaceContainerHighest.withOpacity(0.7),
                child: InkWell(
                  onTap: () {
                    // TODO: Implement Notification action
                  },
                  borderRadius:
                      BorderRadius.circular(isSmallScreen ? 10.0 : 12.0),
                  child: Container(
                    padding: EdgeInsets.all(isSmallScreen ? 8.0 : 10.0),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: colorScheme.onSurfaceVariant,
                      size: isSmallScreen ? 18 : 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight + 10);
  }
}
