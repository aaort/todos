import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/notifications_setup.dart';
import 'package:todos/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationsSetup.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Todos>(
      create: (_) => Todos(),
      child: MaterialApp(
        title: 'Todos',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey,
          primaryColor: Colors.blueGrey,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 45.0,
              fontWeight: FontWeight.w900,
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
            bodyLarge: TextStyle(
              color: Colors.blueGrey,
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.blueGrey,
            size: 27,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.blueGrey,
            actionTextColor: Colors.white,
            contentTextStyle: TextStyle(color: Colors.white),
          ),
        ),
        home: const Home(),
      ),
    );
  }
}
