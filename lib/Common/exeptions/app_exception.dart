class AppException implements Exception {
  final String message;
  final bool isNetworkError;

  const AppException(this.message, {this.isNetworkError = false});

  @override
  String toString() => message;
}