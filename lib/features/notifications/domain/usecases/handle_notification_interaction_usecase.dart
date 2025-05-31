import 'dart:async';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart'; // Use type alias
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

/// This use case exposes the stream of notification interactions from the repository.
/// The presentation layer (Cubit) will listen to this stream.
class HandleNotificationInteractionUseCase {
  final NotificationRepository repository;

  HandleNotificationInteractionUseCase(this.repository);

  Stream<NotificationPayload> call() {
    return repository.notificationInteractionStream;
  }
}