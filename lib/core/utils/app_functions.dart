import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';

TextDirection getTextDirection(String text) {
  final firstLetter = text
      .replaceAll(RegExp(r'[^\p{L}]', unicode: true), '') // keep only letters
      .trim()
      .characters
      .firstOrNull;

  if (firstLetter == null) return TextDirection.ltr;

  final isRTL = RegExp(r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]')
      .hasMatch(firstLetter);
  return isRTL ? TextDirection.rtl : TextDirection.ltr;
}

Color getColorByImportance(ToDoImportance importance) {
  switch (importance) {
    case ToDoImportance.high:
      return Colors.red.shade200;
    case ToDoImportance.medium:
      return Colors.orange.shade200;
    case ToDoImportance.low:
      return Colors.green.shade200;
    default:
      return Colors.cyan.shade200;
  }
}
