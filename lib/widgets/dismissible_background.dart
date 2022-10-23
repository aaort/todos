import 'package:flutter/material.dart';

enum Side {
  right,
  left,
}

class DismissibleBackground extends StatelessWidget {
  final Side side;
  const DismissibleBackground({super.key, required this.side});

  @override
  Widget build(BuildContext context) {
    final isLeft = side == Side.left;
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(17.0),
      ),
      child: Align(
        alignment:
            side == Side.left ? Alignment.centerLeft : Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(
              left: isLeft ? 15.0 : 0.0, right: !isLeft ? 15.0 : 0.0),
          child: const Text('Delete'),
        ),
      ),
    );
  }
}
