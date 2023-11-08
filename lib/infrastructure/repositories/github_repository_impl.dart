import 'package:app_http_client/app_http_client.dart';
import 'package:github_search/domain/entities/item_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/github_repository.dart';
import '../entities/item_entity_impl.dart';

@LazySingleton(as: GithubRepository)
class GithubRepositoryImpl implements GithubRepository {
  final AppHttpClient httpClient;

  const GithubRepositoryImpl(this.httpClient);

  @override
  Future<List<ItemEntity>> getReposItems({
    required String searchQuery,
  }) async {
    if (searchQuery.isEmpty) return [];

    final response = await httpClient.get(
      path: 'search/repositories',
      query: {
        'q': searchQuery,
      },
    );

    return response.data['items']
        .map<ItemEntity>((e) => ItemEntityImpl.fromJson(e))
        .toList();
  }
}
