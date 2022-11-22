import 'package:flutter/material.dart';
import 'package:todos/theme/constants.dart';

class DisabledOpacity extends StatelessWidget {
  final bool enabled;
  final Widget child;

  const DisabledOpacity({
    super.key,
    required this.enabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1 : kDisabledOpacity,
      duration: const Duration(milliseconds: 100),
      child: child,
    );
  }
}
