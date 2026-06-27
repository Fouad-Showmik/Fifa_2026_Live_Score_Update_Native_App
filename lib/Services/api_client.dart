import 'package:dio/dio.dart';
import 'package:fifa_2026_live_score_update/Common/constants/app_constants.dart';
import 'package:fifa_2026_live_score_update/Common/exeptions/app_exception.dart';
import 'package:flutter/foundation.dart';

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

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
          logPrint: (o) => debugPrint('[API] $o'),
        ),
      );
    }

    dio.interceptors.add(_AppInterceptor());
    return dio;
  }
}

class _AppInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isNetwork =
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout;

    final message = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout =>
        'Connection timeout. Check your internet.',
      DioExceptionType.connectionError => 'No internet connection.',
      _ => err.message ?? 'Unexpected error.',
    };

    handler.next(
      err.copyWith(error: AppException(message, isNetworkError: isNetwork)),
    );
  }
}