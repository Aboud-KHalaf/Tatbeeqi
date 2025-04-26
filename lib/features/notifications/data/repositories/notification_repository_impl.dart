import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource dataSource;

  NotificationRepositoryImpl({required this.dataSource});

  // StreamController to forward interaction events to the domain layer (use cases)
  final StreamController<NotificationPayload> _interactionController =
      StreamController.broadcast();

  @override
  Stream<NotificationPayload> get notificationInteractionStream =>
      _interactionController.stream;

  @override
  Future<Either<Failure, Unit>> initialize() async {
    try {
      await dataSource.initializeNotifications(_onInteraction);
      return const Right(unit);
    } on NotificationException catch (e) {
      return Left(NotificationFailure(e.message));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(
          'Failed to initialize notifications: ${e.toString()}'));
    }
  }

  void _onInteraction(NotificationPayload payload) {
    _interactionController.add(payload);
  }

  @override
  Future<Either<Failure, bool>> requestPermission() async {
    try {
      final bool granted = await dataSource.requestPermission();
      if (granted) {
        return const Right(true);
      } else {
        return const Left(
            PermissionFailure('User denied notification permission'));
      }
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(
          GeneralFailure('Failed to request permission: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> showLocalNotification({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  }) async {
    try {
      await dataSource.showLocalNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      );
      return const Right(unit);
    } on NotificationException catch (e) {
      return Left(NotificationFailure(e.message));
    } catch (e) {
      return Left(
          GeneralFailure('Failed to show notification: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String?>> getFcmToken() async {
    try {
      final token = await dataSource.getFcmToken();
      return Right(token);
    } catch (e) {
      return Left(GeneralFailure('Failed to get FCM token: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> subscribeToTopic(String topic) async {
    try {
      await dataSource.subscribeToTopic(topic);
      return const Right(unit);
    } on NotificationException catch (e) {
      return Left(NotificationFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(
          'Failed to subscribe to topic $topic: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> unsubscribeFromTopic(String topic) async {
    try {
      await dataSource.unsubscribeFromTopic(topic);
      return const Right(unit);
    } on NotificationException catch (e) {
      return Left(NotificationFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(
          'Failed to unsubscribe from topic $topic: ${e.toString()}'));
    }
  }

  // Remember to close the stream controller if the repository is disposed
  // (e.g., if registered as non-singleton in GetIt and recreated)
  void dispose() {
    _interactionController.close();
  }
}
