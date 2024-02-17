import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.child, this.variant});

  final VoidCallback? onPressed;
  final Widget child;
  final String? variant;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}