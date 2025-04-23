import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tatbeeqi/core/constants/constants.dart';
import 'package:tatbeeqi/core/constants/notifications_constants.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';

// Define callback types for handling interactions
typedef NotificationTapCallback = void Function(Map<String, dynamic> payload);
typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);

// --- Constants for Local Notifications ---

abstract class NotificationService {
  /// Initializes both FCM and Local Notifications.
  /// Sets up foreground listeners and interaction handlers.
  ///
  /// [onTap] callback is triggered when a notification is tapped.
  Future<void> initialize(NotificationTapCallback onTap);

  /// Requests notification permissions from the user (mainly for iOS and Android 13+).
  Future<bool> requestPermissions();

  /// Shows a local notification immediately.
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  });

  /// Gets the FCM registration token for this device.
  Future<String?> getFcmToken();

  /// Subscribes the device to a specific FCM topic.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes the device from a specific FCM topic.
  Future<void> unsubscribeFromTopic(String topic);
}

class NotificationServiceImpl implements NotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final BackgroundMessageHandler _onBackgroundMessage;

  // Stream controller to broadcast notification taps to the domain layer
  final StreamController<Map<String, dynamic>> _notificationTapController =
      StreamController.broadcast();

  // Callback provided by the domain layer to handle taps
  NotificationTapCallback? _onTapCallback;

  NotificationServiceImpl({
    required FirebaseMessaging firebaseMessaging,
    required FlutterLocalNotificationsPlugin localNotificationsPlugin,
    required BackgroundMessageHandler onBackgroundMessage,
  })  : _firebaseMessaging = firebaseMessaging,
        _localNotificationsPlugin = localNotificationsPlugin,
        _onBackgroundMessage = onBackgroundMessage;

  // --- Initialization ---

  @override
  Future<void> initialize(NotificationTapCallback onTap) async {
    _onTapCallback = onTap; // Store the callback
    try {
      await _initializeLocalNotifications();
      await _initializeFirebaseMessaging();
      _subscribeToTapStream(); // Connect internal stream to external callback
      await _requestPermissionsAndSubscribeToDefaultTopic(); // Request permission and subscribe
    } catch (e, s) {
      // Catch specific exceptions if needed, otherwise log and rethrow a generic one
      print('Error initializing notifications: $e\n$s');
      throw NotificationException(
          message: 'Notification initialization failed: ${e.toString()}');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(AppConstants.androidAppIcon);

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      // onDidReceiveLocalNotification: _onDidReceiveLocalNotification, // Deprecated
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveLocalNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundLocalNotificationResponse,
    );

    // Create the Android notification channel proactively
    await _createAndroidNotificationChannel();
  }

  Future<void> _initializeFirebaseMessaging() async {
    // Handle background messages (must be a top-level or static function)
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is opened from terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('Opened from terminated state via message: ${initialMessage.data}');
      // Use a slight delay to ensure the app navigation context is ready
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleInteraction(initialMessage.data);
      });
    }

    // Handle notification tap when app is opened from background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened from background via message: ${message.data}');
      _handleInteraction(message.data);
    });
  }

  void _subscribeToTapStream() {
    // Ensure the callback is set before listening
    if (_onTapCallback != null) {
      _notificationTapController.stream.listen(_onTapCallback);
    } else {
      print(
          "Warning: NotificationService initialized without an onTap callback.");
    }
  }

  Future<void> _requestPermissionsAndSubscribeToDefaultTopic() async {
    // Request permissions first
    bool granted = await requestPermissions(); // Use the existing method
    if (granted) {
      // Subscribe to the default topic if permission is granted
      try {
        await subscribeToTopic(AppConstants.allUsersSubscribeToTopic);
        print(
            'Automatically subscribed to default topic: ${AppConstants.allUsersSubscribeToTopic}');
      } catch (e) {
        print('Failed to auto-subscribe to default topic: $e');
        // Decide if this failure should throw or just be logged
      }
    } else {
      print('Permission not granted, skipping default topic subscription.');
    }
  }

  // --- Permissions ---

  @override
  Future<bool> requestPermissions() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      final granted =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
              settings.authorizationStatus == AuthorizationStatus.provisional;

      if (granted) {
        print(
            'Notification permission granted (Status: ${settings.authorizationStatus}).');
      } else {
        print(
            'Notification permission denied (Status: ${settings.authorizationStatus}).');
      }
      return granted;
    } catch (e, s) {
      print('Error requesting notification permissions: $e\n$s');
      // Throw a specific permission exception
      throw PermissionException(
          message: 'Failed to request permission: ${e.toString()}');
    }
  }

  // --- Showing Notifications ---

  @override
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    // Ensure the channel exists (important for Android 8.0+)
    await _createAndroidNotificationChannel();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      NotificationsConstants.localNotificationChannelId,
      NotificationsConstants.localNotificationChannelName,
      channelDescription: NotificationsConstants.localNotificationChannelId,

      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker', // Optional small text shown in status bar
    );
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      // sound: 'default', // Optional: specify sound
      // badgeNumber: 1, // Optional: set badge number
      presentAlert: true, // Ensure alert is shown in foreground on iOS
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Convert payload Map to String for local notifications plugin
    final String? payloadString = payload != null ? jsonEncode(payload) : null;

    try {
      await _localNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payloadString,
      );
    } catch (e, s) {
      print('Error showing local notification: $e\n$s');
      throw NotificationException(
          message: 'Failed to show notification: ${e.toString()}');
    }
  }

  // Helper to create the notification channel
  Future<void> _createAndroidNotificationChannel() async {
    // Channel creation is only relevant for Android.
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _localNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        NotificationsConstants.localNotificationChannelId,
        NotificationsConstants.localNotificationChannelName,
        description: NotificationsConstants.localNotificationChannelDescription,
        importance: Importance.max,
      );
      try {
        await androidImplementation.createNotificationChannel(channel);
        print(
            "Android Notification Channel '${NotificationsConstants.localNotificationChannelId}' created or already exists.");
      } catch (e, s) {
        print("Error creating Android Notification Channel: $e\n$s");
        // Decide if this should throw an exception or just log
      }
    }
  }

  // --- FCM Token ---

  @override
  Future<String?> getFcmToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e, s) {
      print('Error getting FCM token: $e\n$s');
      // Usually, don't throw here, let the caller handle null token
      return null;
    }
  }

  // --- Topic Management ---

  @override
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e, s) {
      print('Error subscribing to topic $topic: $e\n$s');
      throw NotificationException(
          message: 'Failed to subscribe to topic $topic: ${e.toString()}');
    }
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e, s) {
      print('Error unsubscribing from topic $topic: $e\n$s');
      throw NotificationException(
          message: 'Failed to unsubscribe from topic $topic: ${e.toString()}');
    }
  }

  // --- Internal Handlers ---

  // Handles FCM messages received while the app is in the foreground.
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Foreground Message received: ${message.notification?.title}');
    RemoteNotification? notification = message.notification;

    // Display the FCM notification locally if it has content
    if (notification != null && !kIsWeb) {
      showLocalNotification(
        id: notification
            .hashCode, // Use notification hashcode as a unique enough ID
        title: notification.title ?? 'Notification',
        body: notification.body ?? '',
        payload: message.data, // Pass FCM data as payload
      );
    }
  }

  // Handler for when user taps a *local* notification (foreground/background)
  void _onDidReceiveLocalNotificationResponse(
      NotificationResponse response) async {
    print('Local notification tapped with payload string: ${response.payload}');
    _handleInteractionFromString(response.payload);
  }

  // Handler for background *local* notification taps (Needs careful setup)
  @pragma('vm:entry-point')
  static void _onDidReceiveBackgroundLocalNotificationResponse(
      NotificationResponse response) {
    // IMPORTANT: This runs in a separate isolate.
    // Avoid heavy logic, instance members, or complex DI.
    // Best practice: Store the payload (e.g., in SharedPreferences)
    // and process it when the main app isolate starts.
    print('Background local notification tapped: ${response.payload}');
    // Example: You might try to decode and store it simply
    // Map<String, dynamic> payload = {};
    // if (response.payload != null) {
    //   try { payload = jsonDecode(response.payload!); } catch (e) { print('Error decoding background payload'); }
    // }
    // Store `payload` for later processing.
  }

  // Central interaction handler - takes Map payload
  void _handleInteraction(Map<String, dynamic> payload) {
    print("Handling interaction with payload map: $payload");
    if (!_notificationTapController.isClosed) {
      _notificationTapController.add(payload);
    } else {
      print("Warning: Interaction received but tap controller is closed.");
    }
  }

  // Helper to decode string payload (from local notifications) and call central handler
  void _handleInteractionFromString(String? payloadString) {
    Map<String, dynamic> payload = {};
    if (payloadString != null && payloadString.isNotEmpty) {
      try {
        // Attempt to decode payload assuming it's a JSON map string
        final decoded = jsonDecode(payloadString);
        if (decoded is Map<String, dynamic>) {
          payload = decoded;
        } else {
          print(
              "Decoded payload is not a Map<String, dynamic>. Type: ${decoded.runtimeType}");
          // Fallback: wrap the raw string in a map if decoding fails or type is wrong
          payload = {'payload_string': payloadString};
        }
      } catch (e) {
        print(
            "Error decoding notification payload string: $e. Treating as raw string.");
        // Fallback: wrap the raw string in a map if decoding fails
        payload = {'payload_string': payloadString};
      }
    } else {
      print("Interaction received with null or empty payload string.");
    }
    _handleInteraction(
        payload); // Call the central handler with the processed payload
  }

  // --- Cleanup ---
  // Consider adding a dispose method if you need to close the stream controller,
  // though typically this service lives for the app's lifetime.
  void dispose() {
    _notificationTapController.close();
  }
}
