import 'dart:async';

import 'package:github_search/domain/repositories/cache_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/item_entity.dart';

@lazySingleton
class CacheSaveFavoriteItemsUseCase {
  final CacheRepository _repo;

  const CacheSaveFavoriteItemsUseCase(
    CacheRepository repo,
  ) : _repo = repo;

  Future<void> execute({
    required List<ItemEntity> items,
  }) =>
      _repo.saveFavoriteItems(items: items);
}
