import 'package:flutter/material.dart';

const black = Color(0xFF323232);
const blackblue = Color(0xFF344966);
const white = Color(0xFFFFFFFF);
const grey = Color(0xFF787878);

class AppTheme {
  final valoTheme = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent,elevation: 0),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: black),
  );
}
