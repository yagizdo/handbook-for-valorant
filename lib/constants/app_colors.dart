import 'package:flutter/material.dart';

const black = Color(0xFF323232);
const black_second = Colors.black45;
const white = Color(0xFFFFFFFF);
const grey = Color(0xFF787878);

class AppTheme {
  final valoTheme = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation: 0),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: black),
  );
}
