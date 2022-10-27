import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart' as ds;

class DismissibleTile extends StatelessWidget {
  final Function onDismiss;
  final Future<bool?> Function()? onConfirmDismiss;
  final VoidCallback onLongPress;
  final Widget child;

  const DismissibleTile({
    super.key,
    required this.onDismiss,
    required this.child,
    required this.onLongPress,
    this.onConfirmDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return ds.DismissibleTile(
      key: UniqueKey(),
      onDismissed: (_) => onDismiss(),
      confirmDismiss:
          onConfirmDismiss != null ? (_) => onConfirmDismiss!() : null,
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
      child: GestureDetector(onLongPress: onLongPress, child: child),
    );
  }
}
