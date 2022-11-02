import 'package:flutter/material.dart';

class Styles {
  final BuildContext context;

  Styles(this.context);

  Styles.of(this.context);

  TextStyle getTodoTextStyle(bool checked) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
        decoration: checked ? TextDecoration.lineThrough : TextDecoration.none);
  }

  BoxDecoration get todoListContainerDecoration {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    );
  }

  EdgeInsets get todoListPadding {
    return EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: Theme.of(context).appBarTheme.titleSpacing!,
    );
  }

  ShapeBorder getRoundedBordersShape(num round) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          round.toDouble(),
        ),
      ),
    );
  }
}
