import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart';

class ShowLocalNotificationParamsEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final NotificationPayload? payload;

  const ShowLocalNotificationParamsEntity({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
  });

  @override
  List<Object?> get props => [id, title, body, payload];
}
