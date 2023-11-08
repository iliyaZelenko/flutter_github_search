import 'app_http_client.dart';

abstract class AppHttpClientTokenRefresher {
  Future<void> refresh(AppHttpClient httpClient);
}
