import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:github_search/application/use_cases/search_repos_use_case.dart';
import 'package:github_search/domain/entities/item_entity.dart';
import 'package:injectable/injectable.dart';

import 'repos_cubit_state.dart';

@injectable
class ReposCubit extends Cubit<ReposCubitState> {
  final SearchReposUseCase _searchReposUseCase;

  ReposCubit(
    this._searchReposUseCase,
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

    try {
      final items = await _searchReposUseCase.execute(
        searchQuery: searchQuery,
      );

      emit(state.copyWith(searchItems: items));
    } finally {
      emit(state.copyWith(searchLoading: false));
    }
  }

  void toggleFavorite(ItemEntity item) {
    ItemEntity map(ItemEntity e) => e == item
        ? ItemEntity(
            e.id,
            name: e.name,
            isFavorite: !e.isFavorite,
          )
        : e;

    final searchItems = state.searchItems.map(map).toList();
    final historyItems = state.historyItems.map(map).toList();
    final favorite =
        [...searchItems, ...historyItems].where((e) => e.isFavorite);
    // Только уникальные элементы
    final favoriteItems = [
      ...{...favorite}
    ];

    emit(
      state.copyWith(
        searchItems: searchItems,
        historyItems: historyItems,
        favoriteItems: favoriteItems,
      ),
    );
  }
}
