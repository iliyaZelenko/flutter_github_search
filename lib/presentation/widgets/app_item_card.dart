import 'package:flutter/material.dart';
import 'package:github_search/presentation/icons/app_icon_favorite_active.dart';

class AppItemCard extends StatelessWidget {
  final String text;
  final bool isFavorite;
  final VoidCallback? onPressedFavorite;

  const AppItemCard({
    super.key,
    required this.text,
    this.isFavorite = false,
    this.onPressedFavorite,
  });

  static const _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: _spacing),
              child: Text(
                text,
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: _spacing),
            child: IconButton(
              onPressed: onPressedFavorite,
              padding: const EdgeInsets.all(10),
              icon: AppIconFavoriteActive(
                color: isFavorite
                    ? theme.colorScheme.primary
                    : theme.textTheme.labelMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
