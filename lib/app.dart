import 'package:flutter/material.dart';
import 'package:valorant_tips/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valo Guide',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
