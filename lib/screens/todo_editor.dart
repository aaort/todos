import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todos/extensions.dart' show RepeatName, Capitalize;
import 'package:todos/helpers.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/widgets/todo_editor/reminder_button.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:todos/widgets/todo_editor/save_todo_button.dart';

// This provider is supposed to be used only inside this file and inside widgets
// That are used by [TodoEditor] widget, in the future files of extracted widgets
// Might become part of this file
final todoProvider = StateNotifierProvider.autoDispose
    .family<TodoState, Todo, Todo?>((ref, Todo? todo) {
  return TodoState(todo);
});

String _reminderText({required WidgetRef ref, required Todo? initialTodo}) {
  final reminder = ref.read(todoProvider(initialTodo)).reminder;
  if (reminder == null) return '';
  if (reminder.dateTime != null) {
    return getReminderText(reminder.dateTime!);
  } else {
    return 'Repeat - ${reminder.repeat!.toName().capitalize()}';
  }
}

class TodoEditor extends HookConsumerWidget {
  final Todo? initialTodo;

  const TodoEditor({this.initialTodo, super.key});

  void clearReminder(WidgetRef ref) {
    ref.read(todoProvider(initialTodo).notifier).updateReminder(null);
  }

  _onTaskChanged(WidgetRef ref, String value) {
    ref.read(todoProvider(initialTodo).notifier).updateValues({'task': value});
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
                _editorTop(context),
                TextField(
                  key: const Key('createTodoInputId'),
                  autofocus: true,
                  controller: taskController,
                  onChanged: (_) => _onTaskChanged(ref, _),
                  textCapitalization: TextCapitalization.sentences,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 30),
                SaveTodoButton(initialTodo: initialTodo),
                const SizedBox(height: 30),
                if (todo.reminder != null)
                  _editorBottom(ref, context)
                else
                  RepeatButton(initialTodo: initialTodo)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editorTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${initialTodo != null ? 'Edit' : 'Add'} Todo',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        ReminderButton(
          initialTodo: initialTodo,
          child: const Icon(Icons.timer_outlined),
        ),
      ],
    );
  }

  Widget _editorBottom(WidgetRef ref, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 8,
          child: ReminderButton(
            initialTodo: initialTodo,
            child: Text(
              _reminderText(ref: ref, initialTodo: initialTodo),
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
    );
  }
}
