import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

class RequestNotificationPermissionUseCase implements UseCase<bool, NoParams> {
  final NotificationRepository repository;

  RequestNotificationPermissionUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) async {
    return await repository.requestPermission();
  }
}
