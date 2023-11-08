import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/presentation/icons/app_icon_left.dart';

import '../bloc/repos_cubit.dart';
import '../bloc/repos_cubit_state.dart';
import '../widgets/app_icon_button.dart';
import '../widgets/app_items_list.dart';
import '../widgets/app_scaffold.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Favorite repos list',
      leading: AppIconButton(
        icon: const AppIconLeft(),
        onPressed: Navigator.of(context).pop,
      ),
      body: BlocBuilder<ReposCubit, ReposCubitState>(
        buildWhen: (prev, curr) => prev.favoriteItems != curr.favoriteItems,
        builder: (context, state) => state.favoriteItems.isEmpty
            ? Center(
                child: Text(
                  'You have no favorites.\n'
                  'Click on star while searching to add first favorite',
                  style: theme.textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              )
            : AppItemsList(items: state.favoriteItems),
      ),
    );
  }
}
