import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/themes/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(
        themeProvider.themeMode == ThemeMode.dark ? Icons.brightness_3 : Icons.brightness_7,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}