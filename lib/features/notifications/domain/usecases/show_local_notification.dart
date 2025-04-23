import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart'; // Use type alias
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

class ShowLocalNotificationUseCase
    implements UseCase<Unit, ShowLocalNotificationParams> {
  final NotificationRepository repository;

  ShowLocalNotificationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(ShowLocalNotificationParams params) async {
    return await repository.showLocalNotification(
      id: params.id,
      title: params.title,
      body: params.body,
      payload: params.payload,
    );
  }
}

class ShowLocalNotificationParams extends Equatable {
  final int id;
  final String title;
  final String body;
  final NotificationPayload? payload;

  const ShowLocalNotificationParams({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
  });

  @override
  List<Object?> get props => [id, title, body, payload];
}