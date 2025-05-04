import 'package:flutter/material.dart';

class TodoDescriptionFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const TodoDescriptionFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        prefixIcon: Icon(Icons.description, color: theme.colorScheme.primary),
        labelStyle:
            TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7)),
        filled: true,
        fillColor: theme.colorScheme.surface,
      ),
      style: TextStyle(color: theme.colorScheme.onSurface),
      maxLines: 3,
      textInputAction: TextInputAction.next,
    );
  }
}
