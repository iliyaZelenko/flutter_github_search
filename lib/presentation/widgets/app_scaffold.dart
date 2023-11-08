import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? forward;
  final Widget? body;

  const AppScaffold({
    super.key,
    required this.title,
    this.leading,
    this.forward,
    this.body,
  });

  static const titleSpacing = 14.0;
  static const contentSpacing = EdgeInsets.only(
    left: 16,
    top: 24,
    right: 16,
  );
  static const bottomLineHeight = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      // Чтобы снять фокус с поля ввода при нажатии вне него
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.background,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(bottomLineHeight),
            child: Container(
              color: theme.colorScheme.surface,
              height: bottomLineHeight,
            ),
          ),
          toolbarHeight: 64,
          automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: titleSpacing,
          title: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: leading,
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: forward,
                ),
              ),
              // ]
            ],
          ),
        ),
        body: Padding(
          padding: contentSpacing,
          child: body,
        ),
      ),
    );
  }
}
