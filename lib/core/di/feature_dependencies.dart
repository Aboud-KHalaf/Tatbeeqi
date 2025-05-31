import 'package:get_it/get_it.dart';
import 'package:tatbeeqi/core/di/localization_dependencies.dart';
import 'package:tatbeeqi/core/di/navigation_dependencies.dart';
import 'package:tatbeeqi/core/di/news_dependencies.dart';
import 'package:tatbeeqi/core/di/notification_dependencies.dart';
import 'package:tatbeeqi/core/di/theme_dependencies.dart';
import 'package:tatbeeqi/core/di/todo_dependencies.dart';
import 'package:tatbeeqi/core/di/courses_dependencies.dart'; // Add this import

void initFeatureDependencies(GetIt sl) {
  initThemeDependencies(sl);
  initLocalizationDependencies(sl);
  initNotificationDependencies(sl);
  initNavigationDependencies(sl);
  initNewsDependencies(sl);
  initTDoDependencies(sl);
  initCoursesDependencies(sl); // Add this line
  // Call other feature dependency initializers here
  // e.g., initAuthDependencies(sl);
}
