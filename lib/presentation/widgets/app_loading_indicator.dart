import 'package:flutter/cupertino.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color? color;

  const AppLoadingIndicator({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) =>
      CupertinoActivityIndicator(color: color);
}
