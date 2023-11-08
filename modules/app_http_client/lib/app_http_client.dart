import 'dart:async';

import 'package:dio/dio.dart';

import 'http_method.dart';
import 'tokens_data.dart';

typedef BaseUrlType = String Function();
typedef OnTokenRefreshedType = void Function(TokensData);

// @throws AppHttpException if http error
abstract class AppHttpClient {
  String get defaultHost;

  String? get token;

  String? get refreshToken;

  Future<void> init();

  Future<void> clearTokens();

  Future<void> rememberTokens(
    String? token,
    String? refreshToken,
  );

  Future<void> refresh();

  Future<Response<T>> performRequest<T>({
    String? host,
    String path = '',
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    required HttpMethod method,
    Map<String, String>? fields,
  });

  Future<Response<T>> get<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
  });

  Future<Response<T>> post<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });

  Future<Response<T>> put<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });

  Future<Response<T>> delete<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });

  Future<Response<T>> patch<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });

  Future<Response<T>> filesPost<T>({
    String? host,
    String path = '',
    Map<String, String>? headers,
    Map<String, String>? query,
    required files,
    Map<String, String>? fields,
  });
}
