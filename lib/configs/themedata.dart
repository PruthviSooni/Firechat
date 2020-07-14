import 'package:flutter/material.dart';

ThemeData themeData(brightness) {
  return ThemeData(
      brightness: brightness,
      appBarTheme: AppBarTheme(
          brightness: brightness == Brightness.light
              ? Brightness.light
              : Brightness.dark),
      textTheme: TextTheme(
          body1: TextStyle(
              color: brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey.shade900)),
      primaryColor:
          brightness == Brightness.dark ? Colors.white : Colors.grey.shade900,
      scaffoldBackgroundColor:
          brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white);
}
