import 'package:dio/dio.dart';

// Copied from original DioErrorType
enum AppHttpErrorType {
  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// The [DioException] was caused by an incorrect status code as configured by
  /// [ValidateStatus].
  badResponse,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  /// Default error type, Some other [Error]. In this case, you can use the
  /// [DioException.error] if it is not null.
  unknown,
}

// Describes the error info  when request failed.
// Copied from original DioError
class AppHttpException implements Exception {
  AppHttpException({
    required this.requestOptions,
    this.response,
    this.type = AppHttpErrorType.unknown,
    this.error,
  });

  // Request info.
  RequestOptions requestOptions;

  // Response info, it may be `null` if the request can't reach to
  // the http server, for example, occurring a dns error, network is not available.
  Response? response;

  AppHttpErrorType type;

  // The original error/exception object; It's usually not null when `type`
  // is DioErrorType.other
  dynamic error;

  StackTrace? _stackTrace;

  set stackTrace(StackTrace? stack) => _stackTrace = stack;

  StackTrace? get stackTrace => _stackTrace;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = '$runtimeType [$type]: ' +
        '\nRequest: ${requestOptions.method} ${requestOptions.uri}' +
        ((response != null)
            ? '\nResponse: ${response?.statusCode} ${response?.statusMessage}'
            : '') +
        '\nMessage:$message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (_stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }
}

// If 401 (Unauthorized)
class AppHttp401Exception extends AppHttpException {
  AppHttp401Exception(AppHttpException exception)
      : super(
          requestOptions: exception.requestOptions,
          response: exception.response,
          type: exception.type,
          error: exception.error,
        );
}
