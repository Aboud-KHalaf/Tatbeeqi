// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tatbeeqi/core/utils/app_logger.dart';

const String _dbName = 'app_database.db'; // Renamed for more general use

// Todos Table
const String _todosTableName = 'todos';
const String _todosColId = 'id';
const String _todosColTitle = 'title';
const String _todosColDescription = 'description';
const String _todosColImportance = 'importance';
const String _todosColDueDate = 'dueDate';
const String _todosColIsCompleted = 'isCompleted';
const String _todosColOrderIndex = 'orderIndex';

// Courses Table
const String coursesTableName = 'courses';
const String coursesColId = 'id';
const String coursesColCourseCode = 'course_code';
const String coursesColCourseName = 'course_name';
const String coursesColDepartmentId = 'department_id';
const String coursesColStudyYear = 'study_year';
const String coursesColSemester = 'semester';
const String coursesColGradeTotal = 'grade_total';
const String coursesColGradeTheoreticalExam = 'grade_theoretical_exam';
const String coursesColWeeklyHoursTheory = 'weekly_hours_theory';
const String coursesColWeeklyHoursPractical = 'weekly_hours_practical';
const String coursesColWeeklyHoursTotal = 'weekly_hours_total';
const String coursesColGradeStudentWork = 'grade_student_work';

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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Define the schema creation logic
  Future<void> _onCreate(Database db, int version) async {
    AppLogger.info('Creating database tables for version $version');
    await _createTodosTable(db);
    await _createCoursesTable(db);
    AppLogger.info('All tables created successfully.');
  }

  Future<void> _createTodosTable(Database db) async {
    AppLogger.info('Creating database table: $_todosTableName');
    await db.execute('''
      CREATE TABLE $_todosTableName (
        $_todosColId TEXT PRIMARY KEY,
        $_todosColTitle TEXT NOT NULL,
        $_todosColDescription TEXT,
        $_todosColImportance INTEGER NOT NULL,
        $_todosColDueDate TEXT,
        $_todosColIsCompleted INTEGER NOT NULL,
        $_todosColOrderIndex INTEGER NOT NULL DEFAULT 0
      )
    ''');
    AppLogger.info('Table $_todosTableName created successfully.');
  }

  Future<void> _createCoursesTable(Database db) async {
    AppLogger.info('Creating database table: $coursesTableName');
    await db.execute('''
      CREATE TABLE $coursesTableName (
        $coursesColId INTEGER PRIMARY KEY,
        $coursesColCourseCode TEXT NOT NULL,
        $coursesColCourseName TEXT NOT NULL,
        $coursesColDepartmentId INTEGER NOT NULL,
        $coursesColStudyYear INTEGER NOT NULL,
        $coursesColSemester INTEGER NOT NULL,
        $coursesColGradeTotal INTEGER,
        $coursesColGradeTheoreticalExam INTEGER,
        $coursesColWeeklyHoursTheory INTEGER,
        $coursesColWeeklyHoursPractical INTEGER,
        $coursesColWeeklyHoursTotal INTEGER,
        $coursesColGradeStudentWork INTEGER
      )
    ''');
    AppLogger.info('Table $coursesTableName created successfully.');
  }

  // Add migration logic for schema changes
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    AppLogger.info(
        'Upgrading database from version $oldVersion to $newVersion');
    if (oldVersion < 2) {
      await _createCoursesTable(db);
    }
    // Add more migration steps for future versions if needed
    // Example: if (oldVersion < 3) { /* changes for version 3 */ }
  }

  // Method to close the database connection
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null; // Reset the instance
      AppLogger.info('Database closed.');
    }
  }
}
