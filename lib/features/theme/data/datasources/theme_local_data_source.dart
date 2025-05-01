import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatbeeqi/core/constants/shared_preferences_keys_constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeMode> getLastThemeMode();

  Future<void> cacheThemeMode(ThemeMode modeToCache);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ThemeMode> getLastThemeMode() {
    final String? themeModeString =
        sharedPreferences.getString(SharedPreferencesKeysConstants.themeKey);

    if (themeModeString != null) {
      try {
        final mode = ThemeMode.values.firstWhere(
          (e) => e.toString() == themeModeString,
        );
        return Future.value(mode);
      } catch (_) {
        throw CacheException('Failed to parse stored theme mode');
      }
    } else {
      throw CacheException('No theme mode found in cache');
    }
  }

  @override
  Future<void> cacheThemeMode(ThemeMode modeToCache) async {
    final success = await sharedPreferences.setString(
      SharedPreferencesKeysConstants.themeKey,
      modeToCache.toString(),
    );  
    if (!success) {
      throw CacheException('Failed to save theme mode to cache');
    }
  }
}
