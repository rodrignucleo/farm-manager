import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    disabledColor: const Color.fromARGB(255, 211, 68, 68),
    primaryColorLight: const Color(0xFFFFFFFF),
    primaryColor: const Color.fromARGB(255, 39, 144, 176),
    canvasColor: const Color.fromARGB(255, 78, 77, 74),
    scaffoldBackgroundColor: const Color.fromARGB(255, 43, 78, 114),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
                color: TAppTheme.appTheme.primaryColorLight,
                fontWeight: FontWeight.bold);
          }
          return TextStyle(color: TAppTheme.appTheme.primaryColorLight);
        },
      ),
    ),

    // primaryColorDark: const Color.fromRGBO(20, 24, 27, 1),
  );
}
