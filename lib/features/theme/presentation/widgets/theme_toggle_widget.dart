import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit/theme_cubit.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          color: theme.colorScheme.secondary,
        ),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            final cubit = context.read<ThemeCubit>();
            final nextMode = value ? ThemeMode.dark : ThemeMode.light;
            cubit.setTheme(nextMode);
          },
          activeColor: theme.colorScheme.primary,
          inactiveThumbColor: theme.colorScheme.surfaceContainerHighest,
          inactiveTrackColor: theme.colorScheme.onSurface.withOpacity(0.3),
        ),
        Icon(
          Icons.dark_mode,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}
