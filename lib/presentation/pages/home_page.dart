import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/presentation/bloc/repos_cubit_state.dart';
import 'package:github_search/presentation/icons/app_icon_favorite_active.dart';
import 'package:github_search/presentation/icons/app_icon_search.dart';
import 'package:github_search/presentation/widgets/app_loading_indicator.dart';
import 'package:github_search/presentation/widgets/app_text_field.dart';

import '../../utils.dart';
import '../bloc/repos_cubit.dart';
import '../widgets/app_icon_button.dart';
import '../widgets/app_items_list.dart';
import '../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final Debounce _searchDebounce =
      Debounce(const Duration(milliseconds: 400));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reposCubit = context.watch<ReposCubit>();

    return AppScaffold(
      title: 'Github repos list',
      forward: AppIconButton(
        icon: const AppIconFavoriteActive(),
        onPressed: () => Navigator.pushNamed(context, '/favorite'),
      ),
      body: BlocBuilder<ReposCubit, ReposCubitState>(
        buildWhen: (prev, curr) =>
            prev.searchItems != curr.searchItems ||
            prev.historyItems != curr.historyItems ||
            prev.searchQuery != curr.searchQuery ||
            prev.searchLoading != curr.searchLoading,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              autofocus: true,
              hint: 'Search',
              prefixIcon: const AppIconSearch(),
              onChanged: (str) =>
                  _searchDebounce(() => reposCubit.search(str ?? '')),
            ),
            const SizedBox(height: 10),
            Text(
              state.searchQuery.isEmpty ? 'Search History' : 'What we found',
              style: theme.textTheme.titleMedium
                  ?.apply(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.searchLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  final showPlaceholder = (state.searchItems.isEmpty &&
                          state.searchQuery.isNotEmpty) ||
                      (state.historyItems.isEmpty && state.searchQuery.isEmpty);

                  if (showPlaceholder) {
                    final text = state.searchQuery.isEmpty
                        ? ('You have empty history.\n'
                            'Click on search to start journey!')
                        : ('Nothing was find for your search.\n'
                            'Please check the spelling');

                    return Center(
                      child: Text(
                        text,
                        style: theme.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return AppItemsList(
                    items: state.searchItems.isEmpty
                        ? state.historyItems.reversed.toList()
                        : state.searchItems,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
