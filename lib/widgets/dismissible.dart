import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';

class Dismissible extends StatelessWidget {
  final Function onDismiss;
  final Future<bool?> Function() onConfirmDismiss;
  final Widget child;

  const Dismissible({
    super.key,
    required this.onDismiss,
    required this.onConfirmDismiss,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DismissibleTile(
      key: UniqueKey(),
      onDismissed: (_) => onDismiss(),
      confirmDismiss: (_) => onConfirmDismiss(),
      ltrDismissedColor: Colors.red,
      ltrOverlay: const Icon(
        Icons.delete_outline_rounded,
        color: Colors.white,
      ),
      rtlDismissedColor: Colors.red,
      rtlOverlay: const Icon(
        Icons.delete_outline_rounded,
        color: Colors.white,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      delayBeforeResize: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
