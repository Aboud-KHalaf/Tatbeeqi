import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

class InitializeNotificationsUseCase implements UseCase<Unit, NoParams> {
  final NotificationRepository repository;

  InitializeNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call([NoParams? params]) async {
    return await repository.initialize();
  }
}
