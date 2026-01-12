import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.amberAccent,
      selectionColor: Colors.amberAccent,
      selectionHandleColor: Colors.amberAccent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 24.0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        25.0,
        20.0,
        0.0,
        22.0,
      ),
    ),
  );
}
