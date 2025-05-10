import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/localization/presentation/widgets/language_switcher_widget.dart';
import 'package:tatbeeqi/features/theme/presentation/widgets/theme_toggle_widget.dart';

class SettingsView extends StatelessWidget {
  static String routePath = '/SettingsView';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeToggleWidget(),
            LanguageSwitcherWidget(),
          ],
        ),
      ),
    );
  }
}
