import 'package:app_http_client/app_http_client.dart';
import 'package:dio/dio.dart';

import 'app_http_client_token_refresher.dart';
import 'app_http_exception.dart';
import 'tokens_data.dart';
import 'tokens_storage.dart';

class AppHttpClientTokenRefresherImpl implements AppHttpClientTokenRefresher {
  final OnTokenRefreshedType? onTokenRefreshed;

  const AppHttpClientTokenRefresherImpl(this.onTokenRefreshed);

  @override
  Future<void> refresh(AppHttpClient httpClient) async {
    final dioForInternalRequests =
        Dio(BaseOptions(baseUrl: httpClient.defaultHost));

    try {
      final refreshToken = httpClient.refreshToken;
      // TODO Ilya: use retry for this request
      final response = await dioForInternalRequests.get(
        '${httpClient.defaultHost}refresh_token/?rt=$refreshToken',
      );
      final data = response.data;

      dioForInternalRequests.close();

      final accessToken = data[TokensStorageKeys.token] as String?;
      final newRefreshToken = data[TokensStorageKeys.refreshToken] as String?;

      onTokenRefreshed?.call(TokensData(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      ));

      await httpClient.rememberTokens(
        accessToken,
        newRefreshToken,
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
          await httpClient.clearTokens();

          throw AppHttp401Exception(AppHttpException(
            requestOptions: e.requestOptions,
            error: e.error,
            response: e.response,
          ));
        }
      }

      rethrow;
    }
  }
}
