import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';

class ToDoModel extends ToDoEntity {
  const ToDoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.importance,
    super.dueDate,
    required super.isCompleted,
  });

  // Factory constructor to create a ToDoModel from a map (e.g., from sqflite)
  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      importance:
          ToDoImportance.values[map['importance'] as int], // Store enum index
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'] as String)
          : null,
      isCompleted: (map['isCompleted'] as int) == 1, // Store bool as 0 or 1
    );
  }

  // Method to convert ToDoModel to a map (e.g., for sqflite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'importance': importance.index, // Store enum index
      'dueDate': dueDate?.toIso8601String(), // Store date as ISO string
      'isCompleted': isCompleted ? 1 : 0, // Store bool as 0 or 1
    };
  }

  // Factory constructor to create a ToDoModel from a ToDoEntity
  factory ToDoModel.fromEntity(ToDoEntity entity) {
    return ToDoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      importance: entity.importance,
      dueDate: entity.dueDate,
      isCompleted: entity.isCompleted,
    );
  }

  // Method to convert ToDoModel back to ToDoEntity
  ToDoEntity toEntity() {
    return ToDoEntity(
      id: id,
      title: title,
      description: description,
      importance: importance,
      dueDate: dueDate,
      isCompleted: isCompleted,
    );
  }
}
