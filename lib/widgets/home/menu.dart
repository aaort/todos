import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/services/auth.dart';
import 'package:todos/main.dart';
import 'package:todos/widgets/auth/logout_button.dart';
import 'package:todos/widgets/home/theme_switch_button.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  void toggleTheme(WidgetRef ref) {
    ref.read(themeModeManagerProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) => IconButton(
        onPressed: () {
          showMenu(
            context: context,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            position:
                RelativeRect.fromLTRB(constraints.maxWidth - 20, 50, 0, 0),
            items: <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () => toggleTheme(ref),
                child: const ThemeSwitchIconButton(),
              ),
              if (!(Auth.isAnonymous ?? true))
                const PopupMenuItem(
                  onTap: Auth.logout,
                  child: LogoutButton(),
                ),
            ],
          );
        },
        icon: const Icon(Icons.menu, color: Colors.white),
      ),
    );
  }
}
