import 'package:flutter/material.dart';
import '../../../../core/widgets/ai_action_button.dart';

class CoursesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoursesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return AppBar(
      title: Text("المقررات",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          )),
      actions: const [
        AiActionButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
