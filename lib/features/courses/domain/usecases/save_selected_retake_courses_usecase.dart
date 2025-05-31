import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/domain/repositories/course_repository.dart';

class SaveSelectedRetakeCoursesUseCase
    implements UseCase<void, List<CourseEntity>> {
  final CourseRepository repository;

  SaveSelectedRetakeCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(List<CourseEntity> params) async {
    return await repository.saveSelectedRetakeCourses(params);
  }
}