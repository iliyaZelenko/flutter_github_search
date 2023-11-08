import 'package:flutter/material.dart';
import 'package:github_search/presentation/icons/app_icon_close.dart';

class AppTextField extends StatefulWidget {
  final bool autofocus;
  final void Function(String?)? onChanged;
  final String? hint;
  final Widget? prefixIcon;

  const AppTextField({
    super.key,
    this.autofocus = false,
    this.onChanged,
    this.hint,
    this.prefixIcon,
  });

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  static const _iconSpacing = 16.0;
  static const _iconSpacingToText = 10.0;
  static const _iconConstraints = BoxConstraints(
    maxHeight: 24,
    maxWidth: 24 + _iconSpacing + _iconSpacingToText,
  );

  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _isFocused = false;
  String? text;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(() {
      setState(() {
        text = _controller.text;
      });
      widget.onChanged?.call(text);
    });
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 56,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hint,
          hintStyle: theme.textTheme.labelMedium,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                left: _iconSpacing, right: _iconSpacingToText),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: _iconConstraints,
          suffixIconConstraints: _iconConstraints,
          suffixIcon: (text == null || text!.isEmpty)
              ? null
              : Padding(
                  padding: const EdgeInsets.only(
                      right: _iconSpacing, left: _iconSpacingToText),
                  child: GestureDetector(
                    onTap: _controller.clear,
                    child: const AppIconClose(),
                  ),
                ),
          filled: true,
          fillColor: _isFocused
              ? theme.colorScheme.secondary
              : theme.colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
