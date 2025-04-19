import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatbeeqi/core/constants/shared_preferences_keys_constants.dart';
import '../../../../core/constants/constants.dart';

abstract class LocaleLocalDataSource {
  /// Gets the cached locale code (e.g., 'en', 'ar') from local storage.
  Future<String> getLastLocaleCode();

  /// Caches the given locale code (e.g., 'en', 'ar') to local storage.
  Future<void> cacheLocaleCode(String localeCode);
}

class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  final SharedPreferences sharedPreferences;

  LocaleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> getLastLocaleCode() {
    final jsonString =
        sharedPreferences.getString(SharedPreferencesKeysConstants.localeKey);
    if (jsonString != null) {
      return Future.value(jsonString);
    } else {
      return Future.value(AppConstants.defaultLocale);
    }
  }

  @override
  Future<void> cacheLocaleCode(String localeCode) {
    return sharedPreferences.setString(
      SharedPreferencesKeysConstants.localeKey,
      localeCode,
    );
  }
}
