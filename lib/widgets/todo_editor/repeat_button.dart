import 'package:flutter/material.dart';
import 'package:todos/extensions.dart';
import 'package:todos/helpers.dart' show ensureKeyboardIsHidden;
import 'package:todos/widgets/common/disabled_opacity.dart';
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
  final Function(Repeat?) onOptionChange;

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
      title: 'Remind',
      options: _repeats,
      onChange: (_) {
        Navigator.pop(context);
        onOptionChange(_);
      },
    );
  }

  onRepeatDeleted() => onOptionChange(null);

  @override
  Widget build(BuildContext context) {
    final repeatName =
        repeat != null ? ' - ${repeat!.toName().capitalize()}' : '';
    return GestureDetector(
      onTap: enabled ? () => onOptionButtonPressed(context) : null,
      child: DisabledOpacity(
        enabled: enabled,
        child: ColoredBox(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Repeat $repeatName',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              // Delete selected repeat option
              if (repeat != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onRepeatDeleted,
                  icon: const Icon(Icons.close),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
