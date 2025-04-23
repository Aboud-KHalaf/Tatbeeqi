/// Exception thrown when a cache-related error occurs.
class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Error accessing cache'});

  @override
  String toString() => 'CacheException: $message';
}

/// Exception thrown when notification permissions are denied or restricted.
class PermissionException implements Exception {
  final String message;
  PermissionException({this.message = 'Notification permission denied'});
  @override
  String toString() => 'PermissionException: $message';
}

/// Exception thrown during notification operations (showing, handling).
class NotificationException implements Exception {
  final String message;
  NotificationException({this.message = 'Notification operation failed'});
  @override
  String toString() => 'NotificationException: $message';
}


// other specific exceptions here if needed
// class ServerException implements Exception {}
// class NetworkException implements Exception {}
