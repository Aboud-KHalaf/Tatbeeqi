import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit/theme_cubit.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final themeCubit = context.read<ThemeCubit>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          color: theme.colorScheme.secondary,
        ),
        Switch(
          value: isDarkMode,
          onChanged: (isDarkModeEnabled) {
            themeCubit.setTheme(
              isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            );
          },
          activeColor: theme.colorScheme.primary,
          inactiveThumbColor: theme.colorScheme.surfaceContainerHighest,
          inactiveTrackColor: theme.colorScheme.onSurface.withOpacity(0.3),
        ),
        Icon(
          Icons.dark_mode,
          color: theme.colorScheme.secondary,
        ),
      ],
    );
  }
}
