import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/navigation/presentation/widgets/nav_bar_item_widget.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class FancyNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final AnimationController animationController;

  const FancyNavBarWidget({
    required this.currentIndex,
    required this.onTap,
    required this.animationController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final navItems = [
      _NavItem(icon: Icons.home, label: l10n.navHome),
      _NavItem(icon: Icons.school, label: l10n.navCourses),
      _NavItem(icon: Icons.chat, label: l10n.navCommunity),
      _NavItem(icon: Icons.more_horiz, label: l10n.navMore),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 72, // Increased height to accommodate Arabic text
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.7)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(navItems.length, (index) {
                return Expanded(
                  child: NavBarItemWidget(
                    icon: navItems[index].icon,
                    label: navItems[index].label,
                    isSelected: currentIndex == index,
                    onTap: () => onTap(index),
                    animationController: animationController,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.label,
  });
}
