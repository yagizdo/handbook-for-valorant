import 'package:flutter/material.dart';

const black = Color(0xFF323232);
const white = Color(0xFFFFFFFF);
const grey = Color(0xFF787878);

class AppTheme {
  final valoTheme = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: AppBarTheme(backgroundColor: black),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: black),
  );
}
