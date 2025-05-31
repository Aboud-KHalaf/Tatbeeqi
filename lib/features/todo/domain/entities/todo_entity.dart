import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For Color

// Enum for importance levels
enum ToDoImportance { low, medium, high }

extension ImportanceExtension on ToDoImportance {
  Color get color {
    switch (this) {
      case ToDoImportance.low:
        return Colors.green;
      case ToDoImportance.medium:
        return Colors.orange;
      case ToDoImportance.high:
        return Colors.red;
    }
  }

  String get name {
    switch (this) {
      case ToDoImportance.low:
        return 'Low';
      case ToDoImportance.medium:
        return 'Medium';
      case ToDoImportance.high:
        return 'High';
    }
  }
}

class ToDoEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final ToDoImportance importance;
  final DateTime? dueDate; // Optional due date
  final bool isCompleted;
  final int orderIndex; // Add this field

  const ToDoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.importance,
    this.dueDate,
    required this.isCompleted,
    required this.orderIndex, // Add to constructor
  });

  // Helper to create a copy with updated values
  ToDoEntity copyWith({
    String? id,
    String? title,
    String? description,
    ToDoImportance? importance,
    DateTime? dueDate,
    bool? isCompleted,
    int? orderIndex, // Add to copyWith
  }) {
    return ToDoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      importance: importance ?? this.importance,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      orderIndex: orderIndex ?? this.orderIndex, // Add to copyWith
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, importance, dueDate, isCompleted, orderIndex]; // Add to props
}
