import 'package:sqflite/sqflite.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/services/database_service.dart';
import 'package:tatbeeqi/features/courses/data/models/course_data_model.dart';

abstract class CourseLocalDataSource {
  Future<List<CourseModel>> getCoursesByStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId});
  Future<void> cacheCourses(
      {required List<CourseModel> courses,
      required int studyYear,
      required int departmentId});
  Future<bool> hasCoursesForStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId});
  Future<void> clearCoursesByStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId});
  Future<void> cacheSelectedRetakeCourses(List<CourseModel> courses);
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final DatabaseService databaseService;

  CourseLocalDataSourceImpl({required this.databaseService});

  @override
  Future<void> cacheCourses(
      {required List<CourseModel> courses,
      required int studyYear,
      required int departmentId}) async {
    try {
      final db = await databaseService.database;
      await db.transaction((txn) async {
        // Clear old courses for this study year before caching new ones
        await txn.delete(
          coursesTableName,
          where: '$coursesColStudyYear = ? AND $coursesColDepartmentId = ?',
          whereArgs: [studyYear, departmentId],
        );
        for (final course in courses) {
          await txn.insert(
            coursesTableName,
            course.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      throw CacheException('Failed to cache courses: ${e.toString()}');
    }
  }

  @override
  Future<List<CourseModel>> getCoursesByStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId}) async {
    try {
      final db = await databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        coursesTableName,
        where:
            '($coursesColStudyYear = ? AND $coursesColDepartmentId = ?) OR $coursesColSemester = ?',
        whereArgs: [studyYear, departmentId, 3],
      );
      if (maps.isNotEmpty) {
        return maps.map((json) => CourseModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw CacheException('Failed to get courses from cache: ${e.toString()}');
    }
  }

  @override
  Future<bool> hasCoursesForStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId}) async {
    try {
      final db = await databaseService.database;
      final List<Map<String, dynamic>> maps = await db.query(
        coursesTableName,
        where: '$coursesColStudyYear = ? AND $coursesColDepartmentId = ?',
        whereArgs: [studyYear, departmentId],
        limit: 1, // only need to know if at least one exists
      );
      return maps.isNotEmpty;
    } catch (e) {
      // If there's an error checking, assume no courses are cached for safety
      return false;
    }
  }

  @override
  Future<void> clearCoursesByStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId}) async {
    try {
      final db = await databaseService.database;
      await db.delete(
        coursesTableName,
        where:
            '($coursesColStudyYear = ? AND $coursesColDepartmentId = ?) OR $coursesColSemester = ?',
        whereArgs: [studyYear, departmentId, 3],
      );
    } catch (e) {
      throw CacheException(
          'Failed to clear courses for study year $studyYear: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheSelectedRetakeCourses(List<CourseModel> courses) async {
    try {
      final db = await databaseService.database;
      await db.transaction((txn) async {
        for (final course in courses) {
          CourseModel updatedCourse =
              course.copyWith(id: course.id + 500, semester: 3);

          await txn.insert(
            coursesTableName,
            updatedCourse.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
    } catch (e) {
      throw CacheException(
          'Failed to cache selected retake courses: ${e.toString()}');
    }
  }
}
