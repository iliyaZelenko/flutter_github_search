import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/domain/entities/item_entity.dart';

import '../bloc/repos_cubit.dart';
import 'app_item_card.dart';

class AppItemsList extends StatelessWidget {
  final List<ItemEntity> items;

  const AppItemsList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final reposCubit = context.watch<ReposCubit>();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bottomSpace = index == items.length - 1 ? 0.0 : 8.0;

        return Padding(
          padding: EdgeInsets.only(bottom: bottomSpace),
          child: AppItemCard(
            key: ValueKey(item.id),
            text: item.name,
            isFavorite: item.isFavorite,
            onPressedFavorite: () => reposCubit.toggleFavorite(item),
          ),
        );
      },
    );
  }
}
