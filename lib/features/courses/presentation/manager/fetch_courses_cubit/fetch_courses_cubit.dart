import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/courses/domain/usecases/get_courses_by_study_year_and_department_id_usecase.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/fetch_courses_cubit/fetch_courses_state.dart';

class FetchCoursesCubit extends Cubit<FetchCoursesState> {
  final GetCoursesByStudyYearAndDepartmentIdUseCase
      _getCoursesByStudyYearUseCase;

  FetchCoursesCubit({
    required GetCoursesByStudyYearAndDepartmentIdUseCase
        getCoursesByStudyYearUseCase,
  })  : _getCoursesByStudyYearUseCase = getCoursesByStudyYearUseCase,
        super(CoursesInitial());

  Future<void> fetchCourses(int studyYear, int departmentId) async {
    emit(CoursesLoading());
    final failureOrCourses =
        await _getCoursesByStudyYearUseCase(studyYear, departmentId);

    failureOrCourses.fold(
      (failure) => emit(CoursesError(failure.message)),
      (courseEntities) {
        emit(CoursesLoaded(courseEntities));
      },
    );
  }

  //TODO
  // double _calculateProgress(CourseEntity entity) {
  //   // Add logic to calculate progress if applicable from entity fields
  //   // e.g. based on grades or completion status if available
  //   if (entity.gradeTotal != null && entity.gradeTotal! > 0) {
  //     return entity.gradeTotal! / 100.0; // Assuming gradeTotal is out of 100
  //   }
  //   return 0.0; // Default progress
  // }
}
