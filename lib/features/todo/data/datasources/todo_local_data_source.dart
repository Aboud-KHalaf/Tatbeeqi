import 'package:sqflite/sqflite.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/services/database_service.dart';
import 'package:tatbeeqi/features/todo/data/models/todo_model.dart';

abstract class ToDoLocalDataSource {
  Future<List<ToDoModel>> getToDos();
  Future<ToDoModel> getToDoById(String id);
  Future<int> addToDo(
      ToDoModel todo); // Consider how orderIndex is set for new todos
  Future<int> updateToDo(ToDoModel todo);
  Future<int> deleteToDo(String id);
  Future<int> toggleToDoCompletion(String id, bool isCompleted);
  Future<void> updateTodosOrder(List<ToDoModel> todos); // Add this method
}

const String _tableName = 'todos';
const String _colId = 'id';
const String _colIsCompleted = 'isCompleted';
const String _colOrderIndex = 'orderIndex';

class ToDoLocalDataSourceImpl implements ToDoLocalDataSource {
  final DatabaseService _databaseService;

  ToDoLocalDataSourceImpl({required DatabaseService databaseService})
      : _databaseService = databaseService;

  @override
  Future<int> addToDo(ToDoModel todo) async {
    try {
      final db = await _databaseService.database;
      // If orderIndex is not set, you might want to calculate it here
      // e.g., by getting MAX(orderIndex) + 1
      // For simplicity, we assume todo.orderIndex is pre-set or handled by usecase/cubit
      final map = todo.toMap();
      final id = await db.insert(
        _tableName,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (id == 0) {
        throw Exception('Failed to insert ToDo.');
      }
      return id;
    } catch (e) {
      throw Exception('Failed to add ToDo: ${e.toString()}');
    }
  }

  @override
  Future<int> deleteToDo(String id) async {
    try {
      final db = await _databaseService.database;
      final result = await db.delete(
        _tableName,
        where: '$_colId = ?',
        whereArgs: [id],
      );
      return result;
    } catch (e) {
      throw Exception('Failed to delete ToDo: ${e.toString()}');
    }
  }

  @override
  Future<ToDoModel> getToDoById(String id) async {
    try {
      final db = await _databaseService.database;
      final maps = await db.query(
        _tableName,
        where: '$_colId = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isNotEmpty) {
        return ToDoModel.fromMap(maps.first);
      } else {
        throw NotFoundException('ToDo with ID $id not found.');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw Exception('Failed to get ToDo by ID: ${e.toString()}');
    }
  }

  @override
  Future<List<ToDoModel>> getToDos() async {
    try {
      final db = await _databaseService.database;
      final maps = await db.query(_tableName,
          orderBy: '$_colOrderIndex ASC'); // Change orderBy
      return maps.map((map) => ToDoModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get ToDos: ${e.toString()}');
    }
  }

  @override
  Future<int> toggleToDoCompletion(String id, bool isCompleted) async {
    try {
      final db = await _databaseService.database;
      final result = await db.update(
        _tableName,
        {_colIsCompleted: isCompleted ? 1 : 0},
        where: '$_colId = ?',
        whereArgs: [id],
      );
      if (result == 0) {}
      return result;
    } catch (e) {
      throw Exception('Failed to toggle ToDo completion: ${e.toString()}');
    }
  }

  @override
  Future<int> updateToDo(ToDoModel todo) async {
    try {
      final db = await _databaseService.database;
      final result = await db.update(
        _tableName,
        todo.toMap(),
        where: '$_colId = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (result == 0) {}
      return result;
    } catch (e) {
      throw Exception('Failed to update ToDo: ${e.toString()}');
    }
  }

  @override
  Future<void> updateTodosOrder(List<ToDoModel> todos) async {
    try {
      final db = await _databaseService.database;
      final batch = db.batch();
      for (final todo in todos) {
        batch.update(
          _tableName,
          {_colOrderIndex: todo.orderIndex},
          where: '$_colId = ?',
          whereArgs: [todo.id],
        );
      }
      await batch.commit(noResult: true);
    } catch (e) {
      throw Exception('Failed to update ToDos order: ${e.toString()}');
    }
  }
}
