import 'package:flutter/material.dart';

class BottomSheetDragHandleWidget extends StatelessWidget {
  const BottomSheetDragHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withOpacity(0.2),
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
    );
  }
}
