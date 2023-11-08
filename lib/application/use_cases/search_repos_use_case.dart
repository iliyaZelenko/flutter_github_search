import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain/entities/item_entity.dart';
import '../../domain/repositories/github_repository.dart';

@lazySingleton
class SearchReposUseCase {
  final GithubRepository _repo;

  const SearchReposUseCase(
    GithubRepository repo,
  ) : _repo = repo;

  Future<List<ItemEntity>> execute({
    required String searchQuery,
  }) =>
      _repo.getReposItems(searchQuery: searchQuery);
}
