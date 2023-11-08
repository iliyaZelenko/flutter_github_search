import 'package:dio/dio.dart';

import '../app_http_exception.dart';

class DioExceptionAdapter {
  const DioExceptionAdapter();

  AppHttpErrorType adapt(DioExceptionType e) {
    switch (e) {
      case DioExceptionType.connectionTimeout:
        return AppHttpErrorType.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return AppHttpErrorType.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return AppHttpErrorType.receiveTimeout;
      case DioExceptionType.cancel:
        return AppHttpErrorType.cancel;
      case DioExceptionType.badCertificate:
        return AppHttpErrorType.badCertificate;
      case DioExceptionType.badResponse:
        return AppHttpErrorType.badResponse;
      case DioExceptionType.connectionError:
        return AppHttpErrorType.connectionError;
      case DioExceptionType.unknown:
        return AppHttpErrorType.unknown;
    }
  }
}
