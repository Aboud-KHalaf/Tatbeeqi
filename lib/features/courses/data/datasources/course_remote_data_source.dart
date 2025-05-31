import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/features/courses/data/models/course_data_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getCoursesByStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId});
  Future<List<CourseModel>> getAllCoursesForReatake(
      {required int studyYear, required int departmentId});
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final SupabaseClient supabaseClient;

  CourseRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<CourseModel>> getCoursesByStudyYearAndDepartmentId(
      {required int studyYear, required int departmentId}) async {
    try {
      final response = await supabaseClient
          .from('courses')
          .select()
          .eq('study_year', studyYear)
          .eq('department_id', departmentId);

      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException('Failed to fetch courses: ${e.toString()}');
    }
  }

  @override
  Future<List<CourseModel>> getAllCoursesForReatake(
      {required int studyYear, required int departmentId}) async {
    try {
      final response = await supabaseClient
          .from('courses')
          .select()
          .neq('study_year', studyYear)
          .eq('department_id', departmentId);

      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((json) => CourseModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException('Failed to fetch courses: ${e.toString()}');
    }
  }
}
