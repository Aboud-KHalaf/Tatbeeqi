import 'package:flutter/material.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class TodoDescriptionFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const TodoDescriptionFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: l10n.todoDescription,
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
