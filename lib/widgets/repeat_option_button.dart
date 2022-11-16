import 'package:flutter/material.dart';
import 'package:todos/helpers/keyboard.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/widgets/pickers.dart';

// Represents available time intervals in seconds
enum RepeatOption {
  hourly,
  daily,
  weekly,
}

final _repeatOptions = <PickerOption<RepeatOption>>[
  PickerOption('Hourly', RepeatOption.hourly),
  PickerOption('Daily', RepeatOption.daily),
  PickerOption('Weekly', RepeatOption.weekly),
];

class RepeatOptionButton extends StatelessWidget {
  final bool enabled;
  final RepeatOption? repeatOption;
  final Function(RepeatOption) onOptionChange;

  const RepeatOptionButton({
    super.key,
    required this.enabled,
    required this.repeatOption,
    required this.onOptionChange,
  });

  void onOptionButtonPressed(BuildContext context) async {
    if (isKeyboardVisible(context)) {
      await hideKeyboardAndWait();
    }
    showOptionPicker<RepeatOption>(
      context: context,
      title: 'Remind me...',
      options: _repeatOptions,
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
      child: Opacity(
        opacity: enabled ? 1 : kDisabledOpacity,
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
              if (repeatOption != null)
                Text(
                  repeatOptionText(repeatOption!),
                  style: Theme.of(context).textTheme.bodySmall,
                )
            ],
          ),
        ),
      ),
    );
  }
}

String repeatOptionText(RepeatOption option) {
  switch (option) {
    case RepeatOption.hourly:
      return 'Hourly';
    case RepeatOption.daily:
      return 'Daily';
    case RepeatOption.weekly:
      return 'Weekly';
  }
}
