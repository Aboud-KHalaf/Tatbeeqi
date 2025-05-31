import 'package:flutter/material.dart';

class TempCourseModel {
  final String id;
  final String title;
  final IconData icon;
  final double progress; // 0.0 to 1.0
  final String term; // e.g., "term1", "term2"

  TempCourseModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.progress,
    required this.term,
  });
}
