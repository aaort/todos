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
final todoProvider = StateProvider.autoDispose.family((ref, Todo? todo) {
  return todo ?? Todo('');
});

String _reminderText(WidgetRef ref) {
  // TODO: pass intialTodo argument for provider
  final reminder = ref.read(todoProvider(null)).reminder;
  if (reminder == null) return '';
  return getReminderText(
      reminder is Duration ? (reminder as Duration).toDateTime() : reminder);
}

class TodoEditor extends HookConsumerWidget {
  final Todo? initialTodo;

  const TodoEditor({this.initialTodo, super.key});

  void clearReminder(WidgetRef ref) {
    ref.read(todoProvider(initialTodo).notifier).update((state) => state
      ..reminder = null
      ..repeat = null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider(initialTodo));
    final taskController = useTextEditingController(text: initialTodo?.task);

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
                    ReminderButton(
                      // Required to pass to the todoProvider as an argument
                      initialTodo: initialTodo,
                      child: const Icon(Icons.timer_outlined),
                    ),
                  ],
                ),
                TextField(
                  key: const Key('createTodoInputId'),
                  autofocus: true,
                  controller: taskController,
                  onChanged: (_) => ref
                      .read(todoProvider(initialTodo).notifier)
                      .update((state) => state.copyWith(state.asMap)),
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
                if (todo.reminder == null)
                  // Initial todo is required to pass it to the todoProvider
                  // to do not create new providers see https://riverpod.dev/docs/concepts/modifiers/family
                  RepeatButton(initialTodo: initialTodo)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
