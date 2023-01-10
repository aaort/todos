import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todos/helpers.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/widgets/todo_editor/reminder_button.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:todos/widgets/todo_editor/save_todo_button.dart';
import 'package:todos/extensions.dart' show Reminder;

// This provided is supposed to be used only inside this file and widgets
// That are used by TodoEditor widget, in the future files of extracted widgets
// Might become part of this file
final todoProvider = StateProvider.autoDispose.family((ref, Map? args) {
  if (args == null) return Todo('');
  final repeat =
      args['repeat'] != null ? Repeat.values.byName(args['repeat']) : null;
  return Todo(
    args['task'],
    reminder: args['reminder'],
    repeat: repeat,
  );
});

void todoTaskListener({required WidgetRef ref, required String task}) {
  ref.read(todoProvider(null).notifier).update((state) {
    return Todo(
      task,
      reminder: state.reminder,
      repeat: state.repeat,
    );
  });
}

String _reminderText(WidgetRef ref) {
  final reminder = ref.read(todoProvider(null)).reminder;
  if (reminder == null) return '';
  return getReminderText(
      reminder is Duration ? (reminder as Duration).toDateTime() : reminder);
}

class TodoEditor extends HookConsumerWidget {
  final Todo? initialTodo;

  const TodoEditor({this.initialTodo, super.key});

  void clearReminder(WidgetRef ref) {
    ref
        .read(todoProvider(null).notifier)
        .update((state) => Todo(state.task, reminder: null, repeat: null));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider(initialTodo?.asMap));
    final taskController = useTextEditingController(text: initialTodo?.task);
    useEffect(() {
      taskController.addListener(() {
        todoTaskListener(ref: ref, task: taskController.text);
      });
      return null;
    }, []);

    return KeyboardDismisser(
      child: ColoredBox(
        // Tap for hiding keyboard will not be detected without this prop
        color: Colors.transparent,
        child: FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${initialTodo != null ? 'Edit' : 'Add'} Todo',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const ReminderButton(child: Icon(Icons.timer_outlined)),
                  ],
                ),
                TextField(
                  key: const Key('createTodoInputId'),
                  autofocus: true,
                  controller: taskController,
                  textCapitalization: TextCapitalization.sentences,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 30),
                SaveTodoButton(initialTodo: initialTodo),
                const SizedBox(height: 30),
                if (todo.reminder != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: ReminderButton(
                          child: Text(
                            _reminderText(ref),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => clearReminder(ref),
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    ],
                  ),
                ],
                if (todo.reminder == null) const RepeatButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
