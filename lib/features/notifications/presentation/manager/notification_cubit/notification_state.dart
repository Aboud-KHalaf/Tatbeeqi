import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/features/notifications/domain/entites/notification_permission_status_entity.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart'; // Use type alias

abstract class NotificationState extends Equatable {
  final NotificationPermissionStatusEntity permissionStatus;
  final String? errorMessage;

  const NotificationState({
    required this.permissionStatus,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [permissionStatus, errorMessage];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial()
      : super(permissionStatus: NotificationPermissionStatusEntity.initial);
}

class NotificationLoading extends NotificationState {
  const NotificationLoading(
      {required super.permissionStatus}); // Keep previous status while loading
}

class NotificationPermissionChecked extends NotificationState {
  const NotificationPermissionChecked({required super.permissionStatus});
}

class NotificationInteractionReceived extends NotificationState {
  final NotificationPayload payload;

  const NotificationInteractionReceived({
    required super.permissionStatus, // Keep track of permission status
    required this.payload,
  });

  @override
  List<Object?> get props => [permissionStatus, payload];
}

class NotificationLocalShowSuccess extends NotificationState {
  const NotificationLocalShowSuccess({required super.permissionStatus});
}

class NotificationTopicSubscribed extends NotificationState {
  final String topic;
  const NotificationTopicSubscribed(
      {required super.permissionStatus, required this.topic});
  @override
  List<Object?> get props => [permissionStatus, topic];
}

class NotificationTopicUnsubscribed extends NotificationState {
  final String topic;
  const NotificationTopicUnsubscribed(
      {required super.permissionStatus, required this.topic});
  @override
  List<Object?> get props => [permissionStatus, topic];
}

class NotificationError extends NotificationState {
  const NotificationError({
    required super.permissionStatus, // Keep track of permission status
    required String message,
  }) : super(errorMessage: message);

  @override
  List<Object?> get props => [permissionStatus, errorMessage];
}
