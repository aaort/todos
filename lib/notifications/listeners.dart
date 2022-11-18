import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/main.dart';
import 'package:todos/notifications/constants.dart';

@pragma("vm:entry-point")
Future<void> onActionReceived(ReceivedAction action) async {
  final todoId = action.payload?['todoId'];
  if (todoId == null) return;
  final context = App.materialAppKey.currentContext;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    if (action.actionLifeCycle != NotificationLifeCycle.AppKilled) {
      // context?.read<TodoManager>().toggleCheckById(todoId, value: true);
      // context?.read<TodoManager>().updateReminder(todoId, null);
    }
  } else {
    final is5Minutes =
        action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
    final duration = Duration(minutes: is5Minutes ? 1 : 2);
    // final todo = context?.read<TodoManager>().getTodoById(todoId);
    // if (context != null && todo != null) {
    // TodoActions(context, todo).updateReminder(DateTime.now().add(duration));
    // }
  }
}
