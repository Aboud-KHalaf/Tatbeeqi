import 'package:tatbeeqi/core/services/notification_service.dart';

typedef NotificationPayload = Map<String, dynamic>;

abstract class NotificationDataSource {
  /// The [onInteraction] callback is invoked when a notification is tapped.
  Future<void> initializeNotifications(
      void Function(NotificationPayload payload) onInteraction);

  Future<bool> requestPermission();

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  });

  Future<String?> getFcmToken();

  Future<void> subscribeToTopic(String topic);

  Future<void> unsubscribeFromTopic(String topic);
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final NotificationService notificationService;

  NotificationDataSourceImpl({required this.notificationService});

  @override
  Future<void> initializeNotifications(
      void Function(NotificationPayload payload) onInteraction) async {
    await notificationService.initialize(onInteraction);
  }

  @override
  Future<bool> requestPermission() async {
    return await notificationService.requestPermissions();
  }

  @override
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  }) async {
    await notificationService.showLocalNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
    );
  }

  @override
  Future<String?> getFcmToken() async {
    return await notificationService.getFcmToken();
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await notificationService.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await notificationService.unsubscribeFromTopic(topic);
  }
}
