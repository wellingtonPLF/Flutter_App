import 'package:flutter/material.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
      iconTheme: IconThemeData(color: CONS_COR_ICONE_APPBAR),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 97, 76, 175),
      secondary: Color.fromARGB(255, 96, 139, 130),
      onPrimary: Color.fromARGB(255, 74, 141, 195),
    ),
    iconTheme: const IconThemeData(
      color: Colors.teal,
    ),
    canvasColor: CONS_COR_BACKGROUND_DRAWER,
    primaryColor: CONS_COR_BOTAO,
    primarySwatch: Colors.teal,
  );
}
