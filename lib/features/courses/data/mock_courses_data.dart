import 'package:flutter/material.dart';
import 'course_model.dart';

// For AppLocalizations, you would typically use a localization package
// For now, we'll use comments as placeholders.
// Example: AppLocalizations.of(context)!.informationSecurity

final List<TempCourseModel> mockCourses = [
  TempCourseModel(
    id: '1',
    title: 'أمن المعلومات', // Information Security
    icon: Icons.security,
    progress: 0.75,
    term: 'term1',
  ),
  TempCourseModel(
    id: '2',
    title: 'هندسة برمجيات متقدمة', // Advanced Software Engineering
    icon: Icons.engineering,
    progress: 0.60,
    term: 'term1',
  ),
  TempCourseModel(
    id: '3',
    title: 'بيانات حاسوب', // Computer Data
    icon: Icons.data_usage,
    progress: 1.0,
    term: 'term1',
  ),
  TempCourseModel(
    id: '4',
    title: 'معالجات و متحكمات', // Processors and Controllers
    icon: Icons.memory,
    progress: 0.40,
    term: 'term1',
  ),
  TempCourseModel(
    id: '5',
    title: 'إدارة شبكات 2', // Network Administration 2
    icon: Icons.network_check,
    progress: 0.55,
    term: 'term1',
  ),
  TempCourseModel(
    id: '6',
    title: 'تطوير تطبيقات الويب', // Web Application Development
    icon: Icons.web,
    progress: 0.80,
    term: 'term2',
  ),
  TempCourseModel(
    id: '7',
    title: 'الذكاء الاصطناعي', // Artificial Intelligence
    icon: Icons.psychology,
    progress: 0.65,
    term: 'term2',
  ),
  TempCourseModel(
    id: '8',
    title: 'قواعد بيانات متقدمة', // Advanced Databases
    icon: Icons.storage,
    progress: 0.70,
    term: 'term2',
  ),
  TempCourseModel(
    id: '9',
    title: 'مادة اختيارية 1', // Elective Course 1 (Retake example)
    icon: Icons.star_border,
    progress: 0.30,
    term: 'term2',
  ),
];
