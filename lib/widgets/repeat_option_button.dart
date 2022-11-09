import 'package:flutter/material.dart';
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
  final RepeatOption? repeatOption;
  final Function(RepeatOption) onOptionChange;

  const RepeatOptionButton({
    super.key,
    required this.repeatOption,
    required this.onOptionChange,
  });

  void onOptionButtonPressed(BuildContext context) {
    showOptionPicker<RepeatOption>(
      context: context,
      title: 'Remind me...',
      options: _repeatOptions,
      onChange: onOptionChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () => onOptionButtonPressed(context),
            child: Text(
              'Repeat',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        if (repeatOption != null)
          Text(
            repeatOptionText(repeatOption!),
            style: Theme.of(context).textTheme.bodySmall,
          )
      ],
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