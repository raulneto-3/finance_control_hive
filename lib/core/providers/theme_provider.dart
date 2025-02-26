import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => FlexColorScheme.light(scheme: FlexScheme.mandyRed).toTheme;
  ThemeData get darkTheme => FlexColorScheme.dark(scheme: FlexScheme.mandyRed).toTheme;
}