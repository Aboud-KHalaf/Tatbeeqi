import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/entites/show_local_notification_params_entity.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

class ShowLocalNotificationUseCase
    implements UseCase<Unit, ShowLocalNotificationParamsEntity> {
  final NotificationRepository repository;

  ShowLocalNotificationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      ShowLocalNotificationParamsEntity params) async {
    return await repository.showLocalNotification(
      id: params.id,
      title: params.title,
      body: params.body,
      payload: params.payload,
    );
  }
}
