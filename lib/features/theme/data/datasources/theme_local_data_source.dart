import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatbeeqi/core/constants/shared_preferences_keys_constants.dart';
import '../../../../core/error/exceptions.dart';

// Interface
abstract class ThemeLocalDataSource {
  /// Gets the cached [ThemeMode] from SharedPreferences.
  ///
  /// Throws [CacheException] if no theme data is stored.
  Future<ThemeMode> getLastThemeMode();

  /// Caches the given [ThemeMode] to SharedPreferences.
  /// Can throw exceptions if SharedPreferences fails.
  Future<void> cacheThemeMode(ThemeMode modeToCache);
}

// Implementation
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ThemeMode> getLastThemeMode() {
    final String? themeModeString =
        sharedPreferences.getString(SharedPreferencesKeysConstants.themeKey);

    if (themeModeString != null) {
      try {
        // Find the ThemeMode enum value matching the stored string
        final mode = ThemeMode.values.firstWhere(
          (e) => e.toString() == themeModeString,
        );
        return Future.value(mode);
      } catch (_) {
        // If parsing fails (e.g., corrupted data), throw CacheException
        throw CacheException(message: 'Failed to parse stored theme mode');
      }
    } else {
      // If no theme is stored, throw CacheException.
      // The repository layer will handle this and decide on a default if necessary.
      throw CacheException(message: 'No theme mode found in cache');
    }
  }

  @override
  Future<void> cacheThemeMode(ThemeMode modeToCache) async {
    // SharedPreferences setString can potentially throw PlatformException
    // We'll let the repository layer handle potential exceptions from here.
    final success = await sharedPreferences.setString(
      SharedPreferencesKeysConstants.themeKey,
      modeToCache.toString(), // Store the enum's string representation
    );
    if (!success) {
      // Optionally throw if SharedPreferences reports failure
      throw CacheException(message: 'Failed to save theme mode to cache');
    }
  }
}
