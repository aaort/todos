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
      context?.read<Todos>().updateReminder(todoId, null);
    }
    TodosIO.toggleCheck(todoId, value: true);
    TodosIO.updateReminder(todoId, null);
  } else {
    final is5Minutes =
        action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
    final duration = Duration(minutes: is5Minutes ? 1 : 2);
    final todo = context?.read<Todos>().getTodoById(todoId);
    if (context != null && todo != null) {
      TodoActions(context, todo).updateReminder(DateTime.now().add(duration));
    }
  }
}
