import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/notifications.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/theme/theme.dart';
import 'package:todos/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Notifications.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static final materialAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Todos>(create: (_) => Todos()),
        ChangeNotifierProvider<ThemeManager>(create: (_) => ThemeManager())
      ],
      child: Builder(builder: (ctx) {
        return MaterialApp(
          key: materialAppKey,
          title: 'Todos',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ctx.watch<ThemeManager>().themeMode,
          home: const Home(),
        );
      }),
    );
  }
}
