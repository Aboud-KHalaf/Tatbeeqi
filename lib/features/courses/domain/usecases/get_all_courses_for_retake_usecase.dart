import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/domain/repositories/course_repository.dart';

class GetAllCoursesForRetakeUsecase {
  final CourseRepository courseRepository;

  GetAllCoursesForRetakeUsecase(this.courseRepository);

  Future<Either<Failure, List<CourseEntity>>> call(
      int studyYear, int departmentId) {
    return courseRepository.getAllCoursesForReatake(
        studyYear: studyYear, departmentId: departmentId);
  }
}
