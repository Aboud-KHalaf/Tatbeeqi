import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.courseCode,
    required super.courseName,
    required super.departmentId,
    required super.studyYear,
    required super.semester,
    super.gradeTotal,
    super.gradeTheoreticalExam,
    super.weeklyHoursTheory,
    super.weeklyHoursPractical,
    super.weeklyHoursTotal,
    super.gradeStudentWork,
  });
  
    factory CourseModel.fromEntity(CourseEntity entity) {
    return CourseModel(
      id: entity.id,
      courseCode: entity.courseCode,
      courseName: entity.courseName,
      departmentId: entity.departmentId,
      studyYear: entity.studyYear,
      semester: entity.semester,
      gradeTotal: entity.gradeTotal,
      gradeTheoreticalExam: entity.gradeTheoreticalExam,
      weeklyHoursTheory: entity.weeklyHoursTheory,
      weeklyHoursPractical: entity.weeklyHoursPractical,
      weeklyHoursTotal: entity.weeklyHoursTotal,
      gradeStudentWork: entity.gradeStudentWork,
    );
  }
  
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int,
      courseCode: json['course_code'] as String,
      courseName: json['course_name'] as String,
      departmentId: json['department_id'] as int,
      studyYear: json['study_year'] as int,
      semester: json['semester'] as int,
      gradeTotal: json['grade_total'] as int?,
      gradeTheoreticalExam: json['grade_theoretical_exam'] as int?,
      weeklyHoursTheory: json['weekly_hours_theory'] as int?,
      weeklyHoursPractical: json['weekly_hours_practical'] as int?,
      weeklyHoursTotal: json['weekly_hours_total'] as int?,
      gradeStudentWork: json['grade_student_work'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_code': courseCode,
      'course_name': courseName,
      'department_id': departmentId,
      'study_year': studyYear,
      'semester': semester,
      'grade_total': gradeTotal,
      'grade_theoretical_exam': gradeTheoreticalExam,
      'weekly_hours_theory': weeklyHoursTheory,
      'weekly_hours_practical': weeklyHoursPractical,
      'weekly_hours_total': weeklyHoursTotal,
      'grade_student_work': gradeStudentWork,
    };
  }
  CourseModel copyWith({
    int? id,
    String? courseCode,
    String? courseName,
    int? departmentId,
    int? studyYear,
    int? semester,
    int? gradeTotal,
    int? gradeTheoreticalExam,
    int? weeklyHoursTheory,
    int? weeklyHoursPractical,
    int? weeklyHoursTotal,
    int? gradeStudentWork,
  }) {
    return CourseModel(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      departmentId: departmentId ?? this.departmentId,
      studyYear: studyYear ?? this.studyYear,
      semester: semester ?? this.semester,
      gradeTotal: gradeTotal ?? this.gradeTotal,
      gradeTheoreticalExam:
          gradeTheoreticalExam ?? this.gradeTheoreticalExam,
      weeklyHoursTheory: weeklyHoursTheory ?? this.weeklyHoursTheory,
      weeklyHoursPractical: weeklyHoursPractical ?? this.weeklyHoursPractical,
      weeklyHoursTotal: weeklyHoursTotal ?? this.weeklyHoursTotal,
      gradeStudentWork: gradeStudentWork ?? this.gradeStudentWork,
    );
  }
}
