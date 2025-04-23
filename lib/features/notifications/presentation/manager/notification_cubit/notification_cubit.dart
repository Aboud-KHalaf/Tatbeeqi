import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/di/service_locator.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/domain/entites/notification_permission_status_entity.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/initialize_notifications.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/request_notification_permission.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/show_local_notification.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/handle_notification_interaction.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/subscribe_to_topic.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/unsubscribe_from_topic.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final InitializeNotificationsUseCase initializeNotificationsUseCase;
  final RequestNotificationPermissionUseCase
      requestNotificationPermissionUseCase;
  final ShowLocalNotificationUseCase showLocalNotificationUseCase;
  final HandleNotificationInteractionUseCase
      handleNotificationInteractionUseCase;
  final SubscribeToTopicUseCase subscribeToTopicUseCase;
  final UnsubscribeFromTopicUseCase unsubscribeFromTopicUseCase;

  StreamSubscription? _interactionSubscription;

  NotificationCubit({
    required this.initializeNotificationsUseCase,
    required this.requestNotificationPermissionUseCase,
    required this.showLocalNotificationUseCase,
    required this.handleNotificationInteractionUseCase,
    required this.subscribeToTopicUseCase,
    required this.unsubscribeFromTopicUseCase,
  }) : super(const NotificationInitial()) {
    _listenToInteractions();
  }

  void _listenToInteractions() {
    _interactionSubscription?.cancel(); // Cancel previous subscription if any
    _interactionSubscription =
        handleNotificationInteractionUseCase().listen((payload) {
      // Emit state when an interaction occurs
      emit(NotificationInteractionReceived(
        permissionStatus:
            state.permissionStatus, // Preserve current permission status
        payload: payload,
      ));
      // You might want to navigate or perform other actions based on the payload here
      // or let the UI layer observe this state change.
      print("Cubit received interaction: $payload");
    }, onError: (error) {
      // Handle stream errors if necessary
      print("Error in notification interaction stream: $error");
      emit(NotificationError(
          permissionStatus: state.permissionStatus,
          message: "Error receiving notification interaction: $error"));
    });
  }

  Future<void> initializeNotifications() async {
    // Don't emit loading here, initialization should be silent mostly
    final result = await initializeNotificationsUseCase(NoParams());
    result.fold(
        (failure) => emit(NotificationError(
            permissionStatus: state.permissionStatus, // Keep previous status
            message: failure.message)), (_) {
      print("Notification system initialized successfully.");
      // --- Add temporary token retrieval ---
      _getAndPrintFcmToken();
      // --- End temporary token retrieval ---
      // Optionally check permission status after initialization
      // checkInitialPermissionStatus(); // Implement this if needed
    });
  }

  // ---  temporary method ---
  Future<void> _getAndPrintFcmToken() async {
    // This is a simplified way for testing. Ideally, you'd have a dedicated use case.
    final tokenResult = await sl<NotificationRepository>()
        .getFcmToken(); // Using service locator directly for brevity
    tokenResult.fold(
      (failure) => print("Error getting FCM token: ${failure.message}"),
      (token) {
        if (token != null) {
          print("FCM TOKEN: $token");
        } else {
          print("FCM Token is null.");
        }
      },
    );
  }

  Future<void> requestPermission() async {
    emit(NotificationLoading(permissionStatus: state.permissionStatus));
    final result = await requestNotificationPermissionUseCase(NoParams());
    result.fold(
      (failure) {
        emit(const NotificationPermissionChecked(
            permissionStatus: NotificationPermissionStatus.denied));
        // Optionally emit error state as well or instead
        emit(NotificationError(
            permissionStatus: NotificationPermissionStatus.denied,
            message: failure.message));
      },
      (granted) => emit(NotificationPermissionChecked(
          permissionStatus: granted
              ? NotificationPermissionStatus.granted
              : NotificationPermissionStatus.denied)),
    );
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  }) async {
    emit(NotificationLoading(permissionStatus: state.permissionStatus));
    final params = ShowLocalNotificationParams(
        id: id, title: title, body: body, payload: payload);
    final result = await showLocalNotificationUseCase(params);
    result.fold(
        (failure) => emit(NotificationError(
            permissionStatus: state.permissionStatus,
            message: failure.message)),
        (_) => emit(NotificationLocalShowSuccess(
            permissionStatus: state.permissionStatus)) // Emit success state
        );
  }

  // Remember to cancel the stream subscription when the Cubit is closed
  Future<void> subscribeToTopic(String topic) async {
    emit(NotificationLoading(permissionStatus: state.permissionStatus));
    final result = await subscribeToTopicUseCase(topic);
    result.fold(
      (failure) => emit(NotificationError(
          permissionStatus: state.permissionStatus, message: failure.message)),
      (_) => emit(NotificationTopicSubscribed(
          permissionStatus: state.permissionStatus, topic: topic)),
    );
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    emit(NotificationLoading(permissionStatus: state.permissionStatus));
    final result = await unsubscribeFromTopicUseCase(topic);
    result.fold(
      (failure) => emit(NotificationError(
          permissionStatus: state.permissionStatus, message: failure.message)),
      (_) => emit(NotificationTopicUnsubscribed(
          permissionStatus: state.permissionStatus, topic: topic)),
    );
  }
  // --- End Topic Methods ---

  @override
  Future<void> close() {
    _interactionSubscription?.cancel();
    return super.close();
  }
}
