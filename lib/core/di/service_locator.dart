import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/core/di/core_dependencies.dart';
import 'package:tatbeeqi/core/di/feature_dependencies.dart';

import 'package:tatbeeqi/core/utils/app_logger.dart';

final sl = GetIt.instance;

// Separate handler for background messages (must be top-level or static)
@pragma('vm:entry-point') // Ensures tree-shaking doesn't remove it
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other services in the background handler, make sure
  // to initialize them first (e.g., Firebase.initializeApp in main.dart)
  // Be careful with dependencies here, as the full app might not be running.
  AppLogger.info("Handling a background message: ${message.messageId}");
  // Avoid heavy processing or UI updates here.
  // Consider simple storage like SharedPreferences if needed.
}

Future<void> init() async {
  // Initialize core dependencies (registers SharedPreferences)
  await initCoreDependencies(sl, _firebaseMessagingBackgroundHandler);

  // Initialize feature-specific dependencies (Call only once)
  initFeatureDependencies(sl);

  // --- External ---
  // Register external dependencies like Dio, etc. if needed
}

// Optional: Reset function for testing or re-initialization
Future<void> resetLocator() async {
  await sl.reset();
  AppLogger.info('🔄 Service Locator Reset');
  // Re-initialize if needed
  // await init();
}
