import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';

class Dismissible extends StatelessWidget {
  final Function onDismissed;
  final Function onConfirmDismissed;
  final Widget child;

  const Dismissible({
    super.key,
    required this.onDismissed,
    required this.onConfirmDismissed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DismissibleTile(
      key: UniqueKey(),
      onDismissed: (_) => onDismissed(),
      confirmDismiss: (_) => onConfirmDismissed(),
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
