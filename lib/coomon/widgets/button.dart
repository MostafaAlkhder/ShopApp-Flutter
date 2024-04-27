import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.style,
  });
  final VoidCallback onPressed;
  final String text;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: Text(
        text.toUpperCase(),
      ),
    );
  }
}
