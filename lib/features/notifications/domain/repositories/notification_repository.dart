import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart'; // Use type alias

abstract class NotificationRepository {
  /// Initializes notification listeners and handlers.
  Future<Either<Failure, Unit>> initialize();

  /// Requests notification permission from the user.
  /// Returns true if granted, Failure otherwise.
  Future<Either<Failure, bool>> requestPermission();

  Future<Either<Failure, Unit>> showLocalNotification({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  });

  Future<Either<Failure, String?>> getFcmToken();

  /// Stream that emits payloads when a notification is interacted with (tapped).
  Stream<NotificationPayload> get notificationInteractionStream;

  /// Subscribes the (device) to an FCM topic.
  Future<Either<Failure, Unit>> subscribeToTopic(String topic);

  /// Unsubscribes the (device) from an FCM topic.
  Future<Either<Failure, Unit>> unsubscribeFromTopic(String topic);
}
