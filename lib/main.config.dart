// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_http_client/app_http_client.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:github_search/application/use_cases/search_repos_use_case.dart'
    as _i6;
import 'package:github_search/domain/repositories/github_repository.dart'
    as _i3;
import 'package:github_search/infrastructure/repositories/github_repository_impl.dart'
    as _i4;
import 'package:github_search/presentation/bloc/repos_cubit.dart' as _i7;
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
    gh.lazySingleton<_i3.GithubRepository>(
        () => _i4.GithubRepositoryImpl(gh<_i5.AppHttpClient>()));
    gh.lazySingleton<_i6.SearchReposUseCase>(
        () => _i6.SearchReposUseCase(gh<_i3.GithubRepository>()));
    gh.factory<_i7.ReposCubit>(
        () => _i7.ReposCubit(gh<_i6.SearchReposUseCase>()));
    return this;
  }
}
