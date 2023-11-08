import 'package:flutter/material.dart';

import '../icons/app_icon.dart';

class AppIconButton extends StatelessWidget {
  final AppIcon icon;
  final void Function()? onPressed;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  static const _size = 44.0;
  static const _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        iconSize: _iconSize,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
