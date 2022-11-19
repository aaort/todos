import 'package:flutter/material.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/widgets/todo_editor/reminder_picker_button.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:todos/widgets/todo_editor/save_todo_button.dart';
import 'package:todos/widgets/todo_icon_button.dart';

class TodoEditor extends StatefulWidget {
  final Todo? initialTodo;

  const TodoEditor({super.key, this.initialTodo});

  @override
  State<TodoEditor> createState() => _TodoEditorState();
}

class _TodoEditorState extends State<TodoEditor> {
  final taskController = TextEditingController();

  dynamic reminder; // Duration | DateTime | null
  Repeat? repeatOption;

  String get _reminderText {
    return getReminderText(
        reminder is Duration ? getDateTimeOfDuration(reminder) : reminder);
  }

  void onReminderChange(dynamic newReminder) {
    setState(() {
      reminder = newReminder;
      repeatOption = null;
    });
  }

  void onRepeatOptionChange(Repeat option) {
    setState(() {
      repeatOption = option;
      reminder = null;
    });
  }

  @override
  void initState() {
    taskController.text = widget.initialTodo?.task ?? '';
    reminder = widget.initialTodo?.reminder;
    repeatOption = widget.initialTodo?.repeat;
    taskController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
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
                    ReminderPickerButton(
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
                  repeatOption: repeatOption,
                ),
                if (reminder != null) ...[
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: ReminderPickerButton(
                          enabled: taskController.text.isNotEmpty,
                          reminder: reminder,
                          onReminderChange: onReminderChange,
                          child: Text(
                            _reminderText,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      TodoIconButton(
                        onPressed: clearReminder,
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                ],
                const SizedBox(height: 30),
                RepeatButton(
                  enabled: taskController.text.isNotEmpty,
                  repeat: repeatOption,
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
      repeatOption = null;
    });
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
