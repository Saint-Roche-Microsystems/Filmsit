// Problems in remote network
class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

// problems in local storage
class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}