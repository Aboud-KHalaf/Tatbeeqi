import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/features/notifications/data/datasources/notification_data_source.dart';
import 'package:tatbeeqi/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/handle_notification_interaction_usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/initialize_notifications_usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/request_notification_permission_usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/show_local_notification_usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/usecases/unsubscribe_from_topic_usecase.dart';
import 'package:tatbeeqi/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';

void initNotificationDependencies(GetIt sl) {
  // --- Notifications Feature ---
  // Manager (Cubit)
  sl.registerFactory(() => NotificationCubit(
        initializeNotificationsUseCase: sl(),
        requestNotificationPermissionUseCase: sl(),
        showLocalNotificationUseCase: sl(),
        handleNotificationInteractionUseCase: sl(),
        subscribeToTopicUseCase: sl(),
        unsubscribeFromTopicUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => InitializeNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => RequestNotificationPermissionUseCase(sl()));
  sl.registerLazySingleton(() => ShowLocalNotificationUseCase(sl()));
  sl.registerLazySingleton(() => HandleNotificationInteractionUseCase(sl()));
  sl.registerLazySingleton(() => SubscribeToTopicUseCase(sl()));
  sl.registerLazySingleton(() => UnsubscribeFromTopicUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(dataSource: sl()));

  // Data Source
  sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImpl(notificationService: sl()));
}
