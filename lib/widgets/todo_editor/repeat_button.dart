import 'package:flutter/material.dart';
import 'package:todos/helpers.dart' show ensureKeyboardIsHidden;
import 'package:todos/widgets/common/disabled.dart';
import 'package:todos/widgets/common/pickers.dart';

enum Repeat {
  hourly,
  daily,
  weekly,
}

final _repeats = <PickerOption<Repeat>>[
  PickerOption('Hourly', Repeat.hourly),
  PickerOption('Daily', Repeat.daily),
  PickerOption('Weekly', Repeat.weekly),
];

class RepeatButton extends StatelessWidget {
  final bool enabled;
  final Repeat? repeat;
  final Function(Repeat) onOptionChange;

  const RepeatButton({
    super.key,
    required this.enabled,
    required this.repeat,
    required this.onOptionChange,
  });

  void onOptionButtonPressed(BuildContext context) async {
    await ensureKeyboardIsHidden(context);
    showOptionPicker<Repeat>(
      context: context,
      title: 'Remind me...',
      options: _repeats,
      onChange: (_) {
        Navigator.pop(context);
        onOptionChange(_);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onOptionButtonPressed(context) : null,
      child: DisabledOpacity(
        enabled: enabled,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Repeat',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              if (repeat != null)
                Text(
                  _repeatText(repeat!),
                  style: Theme.of(context).textTheme.bodySmall,
                )
            ],
          ),
        ),
      ),
    );
  }
}

String _repeatText(Repeat option) {
  switch (option) {
    case Repeat.hourly:
      return 'Hourly';
    case Repeat.daily:
      return 'Daily';
    case Repeat.weekly:
      return 'Weekly';
  }
}
