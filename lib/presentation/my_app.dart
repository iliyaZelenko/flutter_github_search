import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/presentation/bloc/repos_cubit.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'pages/favorite_page.dart';
import 'pages/home_page.dart';
import 'widgets/app_loading_indicator.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _containerDI = GetIt.instance;

  var isAppLoading = true;

  ThemeData get _themeData {
    const textColorPrimary = Color(0xFF211814);
    const textColorPlaceholder = Color(0xFFBFBFBF);
    const header = TextStyle(
      fontSize: 16,
      fontFamily: 'Main',
      fontWeight: FontWeight.w600,
    );
    const textBody = TextStyle(
      fontSize: 14,
      fontFamily: 'Body',
      fontWeight: FontWeight.w400,
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        primary: const Color(0xFF1463F5),
        secondary: const Color(0xFFE5EDFF),
        surface: const Color(0xFFF2F2F2),
        background: const Color(0xFFF9F9F9),
        seedColor: const Color(0xFF1463F5),
      ),
      textTheme: TextTheme(
        titleMedium: header.apply(color: textColorPrimary),
        bodyMedium: textBody.apply(color: textColorPrimary),
        labelMedium: textBody.apply(color: textColorPlaceholder),
      ),
      useMaterial3: true,
    );
  }

  @override
  void initState() {
    super.initState();

    initApp(_containerDI).then((_) => setState(() => isAppLoading = false));
  }

  @override
  Widget build(BuildContext context) => Provider<ContainerDI>.value(
        value: _containerDI,
        child: BlocProvider(
          create: (_) => _containerDI<ReposCubit>(),
          child: MaterialApp(
            title: 'Github search',
            theme: _themeData,
            builder: (context, child) =>
                isAppLoading ? const _MyAppLoading() : child!,
            routes: {
              '/': (_) => const HomePage(),
              '/favorite': (_) => const FavoritePage(),
            },
          ),
        ),
      );
}

class _MyAppLoading extends StatelessWidget {
  const _MyAppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Search App',
            style: theme.textTheme.titleMedium?.apply(
              color: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(height: 16),
          AppLoadingIndicator(
            color: theme.colorScheme.surface,
          ),
        ],
      ),
    );
  }
}
