import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/domain/usecases/get_all_courses_for_retake_usecase.dart';
import 'package:tatbeeqi/features/courses/domain/usecases/save_selected_retake_courses_usecase.dart';

part 'retake_courses_state.dart';

class RetakeCoursesCubit extends Cubit<RetakeCoursesState> {
final GetAllCoursesForRetakeUsecase _getAllCoursesForRetakeUsecase;
  final SaveSelectedRetakeCoursesUseCase _saveSelectedRetakeCoursesUseCase;

  RetakeCoursesCubit({
    required GetAllCoursesForRetakeUsecase getAllCoursesForRetakeUsecase,
    required SaveSelectedRetakeCoursesUseCase saveSelectedRetakeCoursesUseCase,
  })  : _getAllCoursesForRetakeUsecase = getAllCoursesForRetakeUsecase,
        _saveSelectedRetakeCoursesUseCase = saveSelectedRetakeCoursesUseCase,
        super(RetakeCoursesInitial());
  Future<void> fetchAllCoursesForRetake(
      {required int studyYear, required departmentId}) async {
    emit(CoursesRetakeLoading());
    final failureOrCourses =
        await _getAllCoursesForRetakeUsecase(studyYear, departmentId);

    failureOrCourses.fold(
      (failure) => emit(CoursesRetakeError(failure.message)),
      (courseEntities) {
        emit(CoursesRetakeLoaded(courseEntities));
      },
    );
  }
  Future<void> saveRetakeCourses(List<CourseEntity> courses) async {
    emit(RetakeCoursesSaving());
    final failureOrSuccess = await _saveSelectedRetakeCoursesUseCase(courses);

    failureOrSuccess.fold(
      (failure) => emit(RetakeCoursesSaveError(failure.message)),
      (_) => emit(RetakeCoursesSaved()),
    );
  }
}
