import 'package:shared_preferences/shared_preferences.dart';

abstract class TokensStorageKeys {
  static const String token = 'access_token';
  static const String refreshToken = 'rt';
}

abstract class TokensStorage {
  String? get token;

  String? get refreshToken;

  Future<void> init();

  Future<void> save(String? token, String? refreshToken);

  Future<void> clear();
}

class TokensStorageImpl implements TokensStorage {
  late final SharedPreferences _storage;

  @override
  String? get token => _storage.getString(TokensStorageKeys.token);

  @override
  String? get refreshToken =>
      _storage.getString(TokensStorageKeys.refreshToken);

  @override
  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  @override
  Future<void> save(
    String? token,
    String? refreshToken,
  ) async {
    await Future.wait([
      if (token != null) _storage.setString(TokensStorageKeys.token, token),
      if (refreshToken != null)
        _storage.setString(TokensStorageKeys.refreshToken, refreshToken),
    ]);
  }

  @override
  Future<void> clear() async {
    await Future.wait([
      _storage.remove(TokensStorageKeys.token),
      _storage.remove(TokensStorageKeys.refreshToken),
    ]);
  }
}

class TokensTestStorage implements TokensStorage {
  @override
  String? token;

  @override
  String? refreshToken;

  @override
  Future<void> init() async {}

  @override
  Future<void> clear() async {
    token = null;
    refreshToken = null;
  }

  @override
  Future<void> save(String? token, String? refreshToken) async {
    if (token != null) {
      this.token = token;
    }
    if (refreshToken != null) {
      this.refreshToken = refreshToken;
    }
  }
}
