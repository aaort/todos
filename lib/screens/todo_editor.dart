import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todos/helpers.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/widgets/todo_editor/reminder_button.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:todos/widgets/todo_editor/save_todo_button.dart';
import 'package:todos/extensions.dart' show Reminder;

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

class TodoEditor extends ConsumerStatefulWidget {
  final Todo? todo;

  const TodoEditor({super.key, this.todo});

  @override
  ConsumerState<TodoEditor> createState() => _TodoEditorState();
}

class _TodoEditorState extends ConsumerState<TodoEditor> {
  late TextEditingController taskController;

  String get _reminderText {
    final reminder = ref.read(todoProvider(null)).reminder;
    if (reminder == null) return '';
    return getReminderText(
        reminder is Duration ? (reminder as Duration).toDateTime() : reminder);
  }

  void onReminderChange(dynamic newReminder) {
    final reminder =
        newReminder is Duration ? newReminder.toDateTime() : newReminder;
    ref
        .read(todoProvider(null).notifier)
        .update((state) => Todo(state.task, repeat: null, reminder: reminder));
  }

  void onRepeatOptionChange(Repeat? option) {
    ref
        .read(todoProvider(null).notifier)
        .update((state) => Todo(state.task, repeat: option, reminder: null));
  }

  @override
  void initState() {
    taskController = TextEditingController(text: widget.todo?.task ?? '');
    taskController.addListener(() {
      ref.read(todoProvider(null).notifier).update((state) {
        return Todo(
          taskController.text,
          reminder: state.reminder,
          repeat: state.repeat,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(todoProvider(widget.todo?.asMap));
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
                      '${widget.todo != null ? 'Edit' : 'Add'} Todo',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ReminderButton(
                      enabled: todo.task.isNotEmpty,
                      reminder: todo.reminder,
                      onReminderChange: onReminderChange,
                      child: const Icon(Icons.timer_outlined),
                    ),
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
                SaveTodoButton(
                  initialTodo: widget.todo,
                  task: todo.task,
                  reminder: todo.reminder,
                  repeat: todo.repeat,
                ),
                const SizedBox(height: 30),
                if (todo.reminder != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: ReminderButton(
                          enabled: todo.task.isNotEmpty,
                          reminder: todo.reminder,
                          onReminderChange: onReminderChange,
                          child: Text(
                            _reminderText,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: clearReminder,
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    ],
                  ),
                ],
                if (todo.reminder == null)
                  RepeatButton(
                    enabled: todo.task.isNotEmpty,
                    repeat: todo.repeat,
                    onOptionChange: onRepeatOptionChange,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearReminder() {
    ref
        .read(todoProvider(null).notifier)
        .update((state) => Todo(state.task, reminder: null, repeat: null));
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
