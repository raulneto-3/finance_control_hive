import 'package:flex_color_scheme/flex_color_scheme.dart';

class AppTheme {
  static final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.materialBaseline,
    useMaterial3: true,
  );

  static final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.materialBaseline,
    useMaterial3: true,
  );
}