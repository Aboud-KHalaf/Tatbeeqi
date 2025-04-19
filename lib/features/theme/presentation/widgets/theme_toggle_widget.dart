// lib/features/theme/presentation/widgets/theme_toggle.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/theme_cubit.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode from the Cubit
    final currentMode = context.watch<ThemeCubit>().state;

    return IconButton(
      icon: Icon(
        currentMode == ThemeMode.light
            ? Icons.dark_mode
            : currentMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.brightness_auto, // Or specific icon for system
      ),
      tooltip: 'Toggle Theme',
      onPressed: () {
        // Read the Cubit instance (don't need to listen here)
        final cubit = context.read<ThemeCubit>();
        ThemeMode nextMode;

        // Cycle through modes: Light -> Dark -> System -> Light ...
        if (currentMode == ThemeMode.light) {
          nextMode = ThemeMode.dark;
        } else if (currentMode == ThemeMode.dark) {
          nextMode = ThemeMode.light;
        } else {
          nextMode = ThemeMode.system;
        }
        // Call the Cubit method to change the theme
        cubit.setThemeMode(nextMode);
      },
    );
  }
}
