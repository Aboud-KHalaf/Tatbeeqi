/// Exception thrown when a cache-related error occurs.
class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Error accessing cache'});

  @override
  String toString() => 'CacheException: $message';
}

// other specific exceptions here if needed
// class ServerException implements Exception {}
// class NetworkException implements Exception {}