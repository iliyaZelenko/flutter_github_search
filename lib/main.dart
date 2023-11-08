import 'package:app_http_client/app_http_client.dart';
import 'package:app_http_client/dio/dio_http_client_impl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/main.config.dart';
import 'package:injectable/injectable.dart';

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

  await initHttp();

  _initDI();
}

@InjectableInit()
void _initDI() => GetIt.instance.init();
