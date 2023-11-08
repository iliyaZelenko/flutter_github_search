import 'package:cache_data_storage/domain/cache_data_storage.dart';
import 'package:github_search/domain/entities/item_entity.dart';
import 'package:github_search/domain/repositories/cache_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/item_entity_cache_impl.dart';

// Можно было бы и объеденить логику history/favorite, но я это вижу вообще как разные сущности и не до конца понял почему истории можно ставить звёздочки как и репозиториям
@LazySingleton(as: CacheRepository)
class CacheRepositoryImpl implements CacheRepository {
  final CacheDataStorage cache;

  const CacheRepositoryImpl(this.cache);

  static const _historyKey = 'history';

  static const _favoriteKey = 'favorite';

  @override
  Future<List<ItemEntity>> getHistoryItems() async => _getItems(_historyKey);

  @override
  Future<List<ItemEntity>> getFavoriteItems() async => _getItems(_favoriteKey);

  @override
  Future<void> saveHistoryItems({
    required List<ItemEntity> items,
  }) =>
      _saveItems(_historyKey, items);

  @override
  Future<void> saveFavoriteItems({
    required List<ItemEntity> items,
  }) =>
      _saveItems(_favoriteKey, items);

  Future<void> _saveItems(String key, List<ItemEntity> items) async =>
      cache.save(
        key,
        items
            .map((e) => ItemEntityCacheImpl.fromItemEntity(e).toJson())
            .toList(),
      );

  Future<List<ItemEntity>> _getItems(String key) async {
    final items = await cache.get(key) as List<dynamic>?;

    return items
            ?.map<ItemEntity>(
              (e) => ItemEntityCacheImpl.fromJson(e),
            )
            .toList() ??
        [];
  }
}
