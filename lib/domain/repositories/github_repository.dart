import 'package:github_search/domain/entities/item_entity.dart';

abstract class GithubRepository {
  Future<List<ItemEntity>> getReposItems({
    required String searchQuery,
  });
}
