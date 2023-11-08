import 'package:bloc/bloc.dart';

import 'repos_cubit.dart';
import 'repos_cubit_state.dart';

mixin ReposCubitCacheMixin on Cubit<ReposCubitState> {
  ReposCubit get cubit => this as ReposCubit;

  Future<void> initFromCache() async {
    final historyItems = cubit.cacheGetHistoryItemsUseCase.execute();
    final favoriteItems = cubit.cacheGetFavoriteItemsUseCase.execute();

    await Future.wait([
      historyItems,
      favoriteItems,
    ]);

    emit(state.copyWith(
      historyItems: await historyItems,
      favoriteItems: await favoriteItems,
    ));
  }

  Future<void> saveHistoryToCache() =>
      cubit.cacheSaveHistoryItemsUseCase.execute(
        items: state.historyItems,
      );

  Future<void> saveFavoriteToCache() =>
      cubit.cacheSaveFavoriteItemsUseCase.execute(
        items: state.favoriteItems,
      );
}
