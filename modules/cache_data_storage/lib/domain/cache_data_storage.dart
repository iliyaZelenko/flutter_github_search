abstract class CacheDataStorage {
  Future<void> remove(String key);

  Future<void> save(String key, Object value);

  Future<T?> get<T>(String key);

  Future<bool> has(String key);
}
