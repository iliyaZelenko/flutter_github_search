import 'dart:io';

import 'package:dio/dio.dart';

import '../app_http_client.dart';
import '../app_http_client_token_refresher.dart';
import '../app_http_exception.dart';
import '../http_method.dart';

class DioRefreshTokenInterceptor extends QueuedInterceptor {
  final AppHttpClient _httpClient;
  final AppHttpClientTokenRefresher _refresher;

  DioRefreshTokenInterceptor({
    required AppHttpClient httpClient,
    required AppHttpClientTokenRefresher refresher,
  })  : _httpClient = httpClient,
        _refresher = refresher;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('HTTP INTERCEPTOR ${err.requestOptions.uri} $err');

    if (err.response == null) {
      return handler.next(err);
    } else if (err.response!.statusCode == 401) {
      try {
        await _refresher.refresh(_httpClient);
      } catch (e) {
        if (e is AppHttp401Exception) {
          rethrow;
        } else if (e is DioException) {
          return handler.next(err);
        }

        rethrow;
      }

      try {
        // If refreshed, then retry
        return handler.resolve(await _retry(err.requestOptions));
      } catch (e) {
        if (e is DioException) {
          // Если будет плохая свзять, то следующий интерцептор обработает для ретрайа
          return handler.next(err);
        }

        rethrow;
      }
    }

    handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Use new token
    requestOptions.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${_httpClient.token}';

    final withProtocol = requestOptions.uri.host.startsWith('http');
    final host = '${withProtocol ? '' : 'https://'}${requestOptions.uri.host}';

    return _httpClient.performRequest(
      host: host,
      path: requestOptions.uri.path,
      query: requestOptions.queryParameters,
      body: requestOptions.data,
      headers: requestOptions.headers,
      method: HttpMethod.values.byName(requestOptions.method.toLowerCase()),
    );
  }
}
