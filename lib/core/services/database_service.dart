// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tatbeeqi/core/utils/app_logger.dart';

const String _dbName = 'todos_database.db';
const String _tableName = 'todos';
const String _colId = 'id';
const String _colTitle = 'title';
const String _colDescription = 'description';
const String _colImportance = 'importance';
const String _colDueDate = 'dueDate';
const String _colIsCompleted = 'isCompleted';

class DatabaseService {
  Database? _database;
  bool _isInitializing = false; // Prevent race conditions during init

  // Lazy initialization of the database
  Future<Database> get database async {
    // If already initialized, return it
    if (_database != null) return _database!;
    // If currently initializing, wait for it to complete
    while (_isInitializing) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    // If initialized by another caller while waiting, return it
    if (_database != null) return _database!;

    // Start initialization
    _isInitializing = true;
    try {
      _database = await _initDB();
      _isInitializing = false;
      return _database!;
    } catch (e) {
      _isInitializing = false;
      AppLogger.error('Database Initialization Error: $e');
      // Consider re-throwing a specific initialization exception
      throw Exception('Failed to initialize database: ${e.toString()}');
    }
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    AppLogger.info('Database path: $path'); // Log the path for debugging
    return await openDatabase(
      path,
      version: 1, // Increment version for schema migrations
      onCreate: _onCreate,
      // onUpgrade: _onUpgrade, // Add for future schema changes
    );
  }

  // Define the schema creation logic
  Future<void> _onCreate(Database db, int version) async {
    AppLogger.info('Creating database table: $_tableName');
    await db.execute('''
      CREATE TABLE $_tableName (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colTitle TEXT NOT NULL,
        $_colDescription TEXT NOT NULL,
        $_colImportance INTEGER NOT NULL,
        $_colDueDate TEXT,
        $_colIsCompleted INTEGER NOT NULL
      )
    ''');
    AppLogger.info('Table $_tableName created successfully.');
    // Add other tables if needed
  }

  // Optional: Add migration logic if schema changes
  // Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     // await db.execute("ALTER TABLE $_tableName ADD COLUMN new_column TEXT;");
  //   }
  // }

  // Method to close the database connection
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null; // Reset the instance
      AppLogger.info('Database closed.');
    }
  }
}
