import 'dart:convert';

import 'package:hive/hive.dart';

import '../domain/cache_data_storage.dart';

class HiveCacheStorage implements CacheDataStorage {
  final Box _box;

  const HiveCacheStorage(this._box);

  @override
  Future<void> remove(String key) => _box.delete(key);

  @override
  Future<void> save(String key, Object value) =>
      _box.put(key, json.encode(value));

  @override
  Future<T?> get<T>(String key) async {
    final strJson = _box.get(key);

    return strJson == null ? null : json.decode(strJson);
  }

  @override
  Future<bool> has(String key) async => _box.containsKey(key);
}
