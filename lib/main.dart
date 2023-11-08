import 'package:app_http_client/app_http_client.dart';
import 'package:app_http_client/dio/dio_http_client_impl.dart';
import 'package:cache_data_storage/domain/cache_data_storage.dart';
import 'package:cache_data_storage/infrastructure/hive_cache_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/main.config.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import 'presentation/bloc/repos_cubit.dart';
import 'presentation/my_app.dart';

typedef ContainerDI = GetIt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

Future<void> initApp(ContainerDI containerDI) async {
  Future<void> initHttp() async {
    final http = DioHttpClientImpl(
      defaultHost: () => 'https://api.github.com/',
    );
    containerDI.registerSingleton<AppHttpClient>(http);

    await http.init();
  }

  Future<void> initCache() async {
    await Hive.initFlutter();

    containerDI.registerSingleton<CacheDataStorage>(
      HiveCacheStorage(await Hive.openBox('cacheBox')),
    );

    await containerDI<ReposCubit>().initFromCache();
  }

  _initDI();

  await Future.wait([
    initHttp(),
    initCache(),
  ]);
}

@InjectableInit()
void _initDI() => GetIt.instance.init();
