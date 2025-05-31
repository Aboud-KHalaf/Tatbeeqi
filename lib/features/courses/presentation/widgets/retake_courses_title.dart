import 'package:flutter/material.dart';

class RetakeCoursesTitle extends StatelessWidget {
  const RetakeCoursesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Retake Courses', // Consider using AppLocalizations for "Retake Courses"
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}