import 'package:equatable/equatable.dart';
import 'package:github_search/domain/entities/item_entity.dart';

class ReposCubitState extends Equatable {
  final bool searchLoading;
  final String searchQuery;
  final List<ItemEntity> searchItems;
  final List<ItemEntity> historyItems;
  final List<ItemEntity> favoriteItems;

  const ReposCubitState({
    this.searchLoading = false,
    this.searchQuery = '',
    this.searchItems = const [],
    this.historyItems = const [],
    this.favoriteItems = const [],
  });

  ReposCubitState copyWith({
    bool? searchLoading,
    String? searchQuery,
    List<ItemEntity>? searchItems,
    List<ItemEntity>? historyItems,
    List<ItemEntity>? favoriteItems,
  }) =>
      ReposCubitState(
        searchLoading: searchLoading ?? this.searchLoading,
        searchQuery: searchQuery ?? this.searchQuery,
        searchItems: searchItems ?? this.searchItems,
        historyItems: historyItems ?? this.historyItems,
        favoriteItems: favoriteItems ?? this.favoriteItems,
      );

  @override
  List<Object?> get props => [
        searchLoading,
        searchQuery,
        searchItems,
        historyItems,
        favoriteItems,
      ];
}
