import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: 48,
        height: 6,
        decoration: BoxDecoration(
          color: theme.dividerColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}