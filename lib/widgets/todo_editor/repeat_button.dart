import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/extensions.dart';
import 'package:todos/helpers.dart' show ensureKeyboardIsHidden;
import 'package:todos/logic/models/todo.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/common/disabled_opacity.dart';
import 'package:todos/widgets/common/pickers.dart';

enum Repeat {
  hourly,
  daily,
  weekly,
}

const _repeats = <PickerOption<Repeat>>[
  PickerOption('Hourly', Repeat.hourly),
  PickerOption('Daily', Repeat.daily),
  PickerOption('Weekly', Repeat.weekly),
];

class RepeatButton extends ConsumerWidget {
  final Todo? initialTodo;
  const RepeatButton({super.key, this.initialTodo});

  void onOptionButtonPressed(WidgetRef ref) async {
    await ensureKeyboardIsHidden(ref.context);
    showOptionPicker<Repeat>(
      context: ref.context,
      title: 'Remind',
      options: _repeats,
      onChange: (_) {
        Navigator.pop(ref.context);
        onOptionChange(ref: ref, repeat: _);
      },
    );
  }

  void onOptionChange({required WidgetRef ref, Repeat? repeat}) {
    ref
        .read(todoProvider(initialTodo).notifier)
        .update((state) => Todo(state.task, reminder: null, repeat: repeat));
  }

  onRepeatDeleted(WidgetRef ref) => onOptionChange(ref: ref, repeat: null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider(initialTodo));
    final enabled = todo.task.isNotEmpty;
    final repeat = todo.repeat;
    final repeatName =
        repeat != null ? ' - ${repeat.toName().capitalize()}' : '';
    return GestureDetector(
      onTap: enabled ? () => onOptionButtonPressed(ref) : null,
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
              // Delete selected repeat options
              if (repeat != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => onRepeatDeleted(ref),
                  icon: const Icon(Icons.close),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
