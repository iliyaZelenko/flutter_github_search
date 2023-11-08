import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:github_search/application/use_cases/cache_get_favorit_items_use_case.dart';
import 'package:github_search/application/use_cases/cache_get_history_items_use_case.dart';
import 'package:github_search/application/use_cases/cache_save_favorite_items_use_case.dart';
import 'package:github_search/application/use_cases/cache_save_history_items_use_case.dart';
import 'package:github_search/application/use_cases/search_repos_use_case.dart';
import 'package:github_search/domain/entities/item_entity.dart';
import 'package:injectable/injectable.dart';

import 'repos_cubit_cache_mixin.dart';
import 'repos_cubit_state.dart';

@lazySingleton
class ReposCubit extends Cubit<ReposCubitState> with ReposCubitCacheMixin {
  final SearchReposUseCase searchReposUseCase;
  // Cache
  final CacheGetHistoryItemsUseCase cacheGetHistoryItemsUseCase;
  final CacheGetFavoriteItemsUseCase cacheGetFavoriteItemsUseCase;
  final CacheSaveHistoryItemsUseCase cacheSaveHistoryItemsUseCase;
  final CacheSaveFavoriteItemsUseCase cacheSaveFavoriteItemsUseCase;

  ReposCubit(
    this.searchReposUseCase,
    // Cache
    this.cacheGetHistoryItemsUseCase,
    this.cacheGetFavoriteItemsUseCase,
    this.cacheSaveHistoryItemsUseCase,
    this.cacheSaveFavoriteItemsUseCase,
  ) : super(const ReposCubitState());

  void search(String searchQuery) async {
    emit(state.copyWith(
      searchLoading: true,
      searchQuery: searchQuery,
      historyItems: [
        ...state.historyItems,
        // Рандомный айдишник
        if (searchQuery.isNotEmpty)
          ItemEntity(Random.secure().nextInt(1000), name: searchQuery),
      ],
    ));

    saveHistoryToCache();

    try {
      final items = (await searchReposUseCase.execute(
        searchQuery: searchQuery,
      ));

      // Помечаем избранные элементы
      for (var item in items) {
        if (state.favoriteItems.any(((e) => e.isSame(item)))) {
          item.isFavorite = true;
        }
      }

      emit(state.copyWith(searchItems: items));
    } finally {
      emit(state.copyWith(searchLoading: false));
    }
  }

  void toggleFavorite(ItemEntity item) {
    ItemEntity toggleIfNeed(ItemEntity e) => e.isSame(item)
        ? ItemEntity(
            e.id,
            name: e.name,
            isFavorite: !e.isFavorite,
          )
        : e;

    final favoriteItems = state.favoriteItems.map(toggleIfNeed).toList();
    final searchItems = state.searchItems.map(toggleIfNeed).toList();
    final historyItems = state.historyItems.map(toggleIfNeed).toList();
    final favorite = [
      ...favoriteItems,
      ...searchItems,
      ...historyItems,
    ].where((e) => e.isFavorite);
    // Только уникальные элементы
    final actualFavoriteItems = [
      ...{...favorite}
    ];

    emit(
      state.copyWith(
        searchItems: searchItems,
        historyItems: historyItems,
        favoriteItems: actualFavoriteItems,
      ),
    );

    saveHistoryToCache();
    saveFavoriteToCache();
  }
}
