import 'package:flutter/material.dart';

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
