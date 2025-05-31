part of 'retake_courses_cubit.dart';

sealed class RetakeCoursesState extends Equatable {
  const RetakeCoursesState();

  @override
  List<Object> get props => [];
}

final class RetakeCoursesInitial extends RetakeCoursesState {}

class CoursesRetakeLoading extends RetakeCoursesState {}

class CoursesRetakeLoaded extends RetakeCoursesState {
  final List<CourseEntity> courseEntities;
  const CoursesRetakeLoaded(this.courseEntities);

  @override
  List<Object> get props => [courseEntities];
}

class CoursesRetakeError extends RetakeCoursesState {
  final String message;

  const CoursesRetakeError(this.message);

  @override
  List<Object> get props => [message];
}


class RetakeCoursesSaving extends RetakeCoursesState {}

class RetakeCoursesSaved extends RetakeCoursesState {}

class RetakeCoursesSaveError extends RetakeCoursesState {
  final String message;
  const RetakeCoursesSaveError(this.message);

  @override
  List<Object> get props => [message];
}
