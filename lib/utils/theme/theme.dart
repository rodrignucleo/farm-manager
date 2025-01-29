import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    primaryColorLight: const Color(0xFFFFFFFF),
    primaryColor: const Color(0xFF8C9EFF),
    canvasColor: const Color(0xFF1A237E),
    scaffoldBackgroundColor: const Color(0xFF14181B),
    primaryColorDark: const Color.fromRGBO(20, 24, 27, 1),
  );
}
