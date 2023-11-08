// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_http_client/app_http_client.dart' as _i10;
import 'package:cache_data_storage/domain/cache_data_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:github_search/application/use_cases/cache_get_favorit_items_use_case.dart'
    as _i12;
import 'package:github_search/application/use_cases/cache_get_history_items_use_case.dart'
    as _i13;
import 'package:github_search/application/use_cases/cache_save_favorite_items_use_case.dart'
    as _i6;
import 'package:github_search/application/use_cases/cache_save_history_items_use_case.dart'
    as _i7;
import 'package:github_search/application/use_cases/search_repos_use_case.dart'
    as _i11;
import 'package:github_search/domain/repositories/cache_repository.dart' as _i3;
import 'package:github_search/domain/repositories/github_repository.dart'
    as _i8;
import 'package:github_search/infrastructure/repositories/cache_repository_impl.dart'
    as _i4;
import 'package:github_search/infrastructure/repositories/github_repository_impl.dart'
    as _i9;
import 'package:github_search/presentation/bloc/repos_cubit.dart' as _i14;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.CacheRepository>(
        () => _i4.CacheRepositoryImpl(gh<_i5.CacheDataStorage>()));
    gh.lazySingleton<_i6.CacheSaveFavoriteItemsUseCase>(
        () => _i6.CacheSaveFavoriteItemsUseCase(gh<_i3.CacheRepository>()));
    gh.lazySingleton<_i7.CacheSaveHistoryItemsUseCase>(
        () => _i7.CacheSaveHistoryItemsUseCase(gh<_i3.CacheRepository>()));
    gh.lazySingleton<_i8.GithubRepository>(
        () => _i9.GithubRepositoryImpl(gh<_i10.AppHttpClient>()));
    gh.lazySingleton<_i11.SearchReposUseCase>(
        () => _i11.SearchReposUseCase(gh<_i8.GithubRepository>()));
    gh.lazySingleton<_i12.CacheGetFavoriteItemsUseCase>(
        () => _i12.CacheGetFavoriteItemsUseCase(gh<_i3.CacheRepository>()));
    gh.lazySingleton<_i13.CacheGetHistoryItemsUseCase>(
        () => _i13.CacheGetHistoryItemsUseCase(gh<_i3.CacheRepository>()));
    gh.lazySingleton<_i14.ReposCubit>(() => _i14.ReposCubit(
          gh<_i11.SearchReposUseCase>(),
          gh<_i13.CacheGetHistoryItemsUseCase>(),
          gh<_i12.CacheGetFavoriteItemsUseCase>(),
          gh<_i7.CacheSaveHistoryItemsUseCase>(),
          gh<_i6.CacheSaveFavoriteItemsUseCase>(),
        ));
    return this;
  }
}
