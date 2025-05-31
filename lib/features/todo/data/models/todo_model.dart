import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';

class ToDoModel extends ToDoEntity {
  const ToDoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.importance,
    super.dueDate,
    required super.isCompleted,
    required super.orderIndex, // Add to constructor
  });

  factory ToDoModel.fromEntity(ToDoEntity entity) {
    return ToDoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      importance: entity.importance,
      dueDate: entity.dueDate,
      isCompleted: entity.isCompleted,
      orderIndex: entity.orderIndex, // Add here
    );
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      importance: ToDoImportance.values[map['importance'] as int],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate'] as String) : null,
      isCompleted: map['isCompleted'] == 1,
      orderIndex: map['orderIndex'] as int, // Add here
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'importance': importance.index,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'orderIndex': orderIndex, // Add here
    };
  }
}
