import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';

abstract class FetchCoursesState extends Equatable {
  const FetchCoursesState();

  @override
  List<Object> get props => [];

  get courseEntities => null;
}

class CoursesInitial extends FetchCoursesState {}

class CoursesLoading extends FetchCoursesState {}

class CoursesError extends FetchCoursesState {
  final String message;

  const CoursesError(this.message);

  @override
  List<Object> get props => [message];
}

class CoursesLoaded extends FetchCoursesState {
  final List<CourseEntity> courseEntities;
  const CoursesLoaded(this.courseEntities);

  @override
  List<Object> get props => [courseEntities];
}
