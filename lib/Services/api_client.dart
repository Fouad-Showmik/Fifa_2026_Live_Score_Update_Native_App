import 'package:dio/dio.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';

class ApiClient {
  static Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    dio.interceptors.add(_AppInterceptor());
    return dio;
  }
}

class _AppInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final msg = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout   => 'Connection timeout. Check your internet.',
      DioExceptionType.connectionError  => 'No internet connection.',
      _                                 => err.message ?? 'Unexpected error.',
    };
    handler.next(err.copyWith(error: Exception(msg)));
  }
}