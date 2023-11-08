import 'dart:async';

import 'package:github_search/domain/repositories/cache_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/item_entity.dart';

@lazySingleton
class CacheGetFavoriteItemsUseCase {
  final CacheRepository _repo;

  const CacheGetFavoriteItemsUseCase(
    CacheRepository repo,
  ) : _repo = repo;

  Future<List<ItemEntity>> execute() => _repo.getFavoriteItems();
}
