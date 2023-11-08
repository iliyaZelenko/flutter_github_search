import 'package:github_search/domain/entities/item_entity.dart';

abstract class CacheRepository {
  Future<List<ItemEntity>> getHistoryItems();

  Future<List<ItemEntity>> getFavoriteItems();

  Future<void> saveHistoryItems({
    required List<ItemEntity> items,
  });

  Future<void> saveFavoriteItems({
    required List<ItemEntity> items,
  });
}
