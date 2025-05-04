import 'package:flutter/material.dart';

class ToDoNoDataAvaiableWidget extends StatelessWidget {
  const ToDoNoDataAvaiableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        'No data available',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }
}
