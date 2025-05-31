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
  }
}

IconData getIconByCourseId(int id) {
  switch (id) {
    case 1: // الرياضيات الأساسية
    case 8:
    case 50:
    case 57:
      return Icons.calculate;

    case 2: // الفيزياء الأساسية
    case 9:
    case 15:
      return Icons.science;

    case 3: // الميكانيك التطبيقي
    case 12:
      return Icons.build;

    case 4: // الرسم الهندسي
    case 10:
    case 19:
      return Icons.architecture;

    case 5: // اللغة العربية
    case 49:
      return Icons.language;

    case 6: // اللغة الأجنبية
    case 13:
    case 14:
    case 48:
    case 55:
    case 61:
    case 67:
      return Icons.translate;

    case 7: // معلوماتية
    case 53:
    case 54:
    case 60:
    case 64:
    case 69:
    case 71:
    case 83:
    case 94:
      return Icons.computer;

    case 11: // الثقافة القومية الاشتراكية
    case 56:
      return Icons.flag;

    case 16: // أسس الكهرباء
    case 23:
      return Icons.flash_on;

    case 21: // ميكانيك الموائع
      return Icons.water;

    case 22: // اسس التبريد
    case 24:
    case 29:
    case 34:
    case 35:
    case 37:
    case 42:
    case 46:
    case 47:
      return Icons.ac_unit;

    case 26: // أجهزة الحماية والتحكم
      return Icons.security;

    case 31: // الامن الصناعي والسلامة المهنية
      return Icons.health_and_safety;

    case 33: // إدارة الطاقة
      return Icons.energy_savings_leaf;

    case 43: // إدارة المشاريع الصناعية
    case 92:
      return Icons.work;

    case 62: // هندسة الاتصالات
    case 74:
      return Icons.signal_cellular_alt;

    case 68: // الشبكات
    case 80:
    case 81:
    case 88:
    case 95:
      return Icons.wifi;

    case 77: // الذكاء الصنعي
      return Icons.smart_toy;

    case 86: // بيانات الحاسوب
    case 91:
      return Icons.bar_chart;

    case 93: // المترجمات
      return Icons.code;

    case 96: // مشروع تخرج
    case 90:
    case 38:
    case 44:
      return Icons.school;

    default:
      return Icons.book; // Default for unidentified courses
  }
}
