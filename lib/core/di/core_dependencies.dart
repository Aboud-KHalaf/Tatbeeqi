import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Add this import
import 'package:tatbeeqi/core/services/database_service.dart';
import 'package:tatbeeqi/core/services/notification_service.dart';

// Type definition for the background message handler function
typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);

Future<void> initCoreDependencies(
    GetIt sl, BackgroundMessageHandler onBackgroundMessage) async {
  // --- External Dependencies ---
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Supabase Client
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Firebase Messaging & Local Notifications
  sl.registerLazySingleton(() => FirebaseMessaging.instance);
  sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());

  // --- Core Services ---
  sl.registerLazySingleton<NotificationService>(() => NotificationServiceImpl(
        firebaseMessaging: sl(),
        localNotificationsPlugin: sl(),
        onBackgroundMessage: onBackgroundMessage, // Pass the handler
      ));
       sl.registerLazySingleton(() => DatabaseService());

  // Register other core services (e.g., HttpClient, Analytics) here
}
