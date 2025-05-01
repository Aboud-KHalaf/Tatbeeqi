import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      elevation: 8,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home), label: l10n.navHome),
        BottomNavigationBarItem(
            icon: const Icon(Icons.school), label: l10n.navCourses),
        BottomNavigationBarItem(
            icon: const Icon(Icons.chat), label: l10n.navCommunity),
        BottomNavigationBarItem(
            icon: const Icon(Icons.more), label: l10n.navMore),
      ],
    );
  }
}
