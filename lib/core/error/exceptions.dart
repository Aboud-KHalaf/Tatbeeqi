// Represents errors during data fetching or processing (e.g., from APIs, databases)

class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() {
    return message;
  }
}

class PermissionException implements Exception {
  final String message;

  PermissionException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NotificationException implements Exception {
  final String message;

  NotificationException(this.message);

  @override
  String toString() {
    return message;
  }
}

// Add other specific exceptions as needed (e.g., NetworkException, DatabaseException)

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}
