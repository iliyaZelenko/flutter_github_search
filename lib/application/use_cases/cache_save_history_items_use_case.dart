import 'dart:async';

import 'package:github_search/domain/repositories/cache_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/item_entity.dart';

@lazySingleton
class CacheSaveHistoryItemsUseCase {
  final CacheRepository _repo;

  const CacheSaveHistoryItemsUseCase(
    CacheRepository repo,
  ) : _repo = repo;

  Future<void> execute({
    required List<ItemEntity> items,
  }) =>
      _repo.saveHistoryItems(items: items);
}
