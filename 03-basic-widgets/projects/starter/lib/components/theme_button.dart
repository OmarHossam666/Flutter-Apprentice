import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, required this.changeThemeMode});

  final Function changeThemeMode;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    return IconButton(
        onPressed: () => changeThemeMode(!isLightMode),
        icon: isLightMode
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined));
  }
}
