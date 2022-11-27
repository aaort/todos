import 'package:flutter/material.dart';
import 'package:todos/helpers.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/widgets/common/dismiss_keyboard.dart';
import 'package:todos/widgets/todo_editor/reminder_button.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:todos/widgets/todo_editor/save_todo_button.dart';
import 'package:todos/extensions.dart' show Reminder;

class TodoEditor extends StatefulWidget {
  final Todo? initialTodo;

  const TodoEditor({super.key, this.initialTodo});

  @override
  State<TodoEditor> createState() => _TodoEditorState();
}

class _TodoEditorState extends State<TodoEditor> {
  late TextEditingController taskController;
  dynamic reminder; // Duration | DateTime | null
  Repeat? repeat;

  String get _reminderText {
    return getReminderText(
        reminder is Duration ? (reminder as Duration).toDateTime() : reminder);
  }

  void onReminderChange(dynamic newReminder) {
    setState(() {
      reminder = newReminder;
      repeat = null;
    });
  }

  void onRepeatOptionChange(Repeat option) {
    setState(() {
      repeat = option;
      reminder = null;
    });
  }

  @override
  void initState() {
    taskController =
        TextEditingController(text: widget.initialTodo?.task ?? '');
    reminder = widget.initialTodo?.reminder;
    repeat = widget.initialTodo?.repeat;
    taskController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Container(
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
                      '${widget.initialTodo != null ? 'Edit' : 'Add'} Todo',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ReminderButton(
                      enabled: taskController.text.isNotEmpty,
                      reminder: reminder,
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
                  initialTodo: widget.initialTodo,
                  task: taskController.text,
                  reminder: reminder,
                  repeat: repeat,
                ),
                if (reminder != null) ...[
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: ReminderButton(
                          enabled: taskController.text.isNotEmpty,
                          reminder: reminder,
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
                const SizedBox(height: 30),
                RepeatButton(
                  enabled: taskController.text.isNotEmpty,
                  repeat: repeat,
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
    setState(() {
      reminder = null;
      repeat = null;
    });
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
