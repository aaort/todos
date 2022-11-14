import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/main.dart';
import 'package:todos/notifications/constants.dart';

Future<void> onActionReceivedMethod(ReceivedAction action) async {
  final todoId = action.payload?['todoId'];
  if (todoId == null) return;
  final context = App.materialAppKey.currentContext;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    if (action.actionLifeCycle != NotificationLifeCycle.AppKilled) {
      context?.read<Todos>().toggleCheckById(todoId, value: true);
    }
    TodosIO.toggleCheck(action.payload!['todoId']!, value: true);
  } else {
    late Duration duration;
    if (action.buttonKeyPressed == notificationActions[in5MinutesButtonKey]) {
      duration = const Duration(minutes: 5);
    } else {
      duration = const Duration(minutes: 15);
    }
    final newReminder = DateTime.now().add(duration);
    final todo = context?.read<Todos>().getTodoById(todoId);
    if (context != null && todo != null) {
      TodoActions(context, todo).updateReminder(newReminder);
    }
  }
}
