import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/theme/theme_manager.dart';

class ThemeSwitchIconButton extends StatelessWidget {
  const ThemeSwitchIconButton({super.key});

  void toggleTheme(BuildContext context) {
    context.read<ThemeManager>().toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeManager>().isDark;

    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: child.key == const ValueKey('dark_key')
              ? Tween<double>(begin: 1, end: 0.75).animate(anim)
              : Tween<double>(begin: 0.75, end: 1).animate(anim),
          child: ScaleTransition(scale: anim, child: child),
        ),
        child: isDarkMode ? _darkIcon : _lightIcon,
      ),
      onPressed: () {
        toggleTheme(context);
      },
    );
  }
}

const _darkIcon =
    Icon(Icons.dark_mode, key: ValueKey('dark_key'), color: Colors.white);
const _lightIcon =
    Icon(Icons.light_mode, key: ValueKey('light_key'), color: Colors.white);
