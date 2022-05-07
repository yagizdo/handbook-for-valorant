import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<Tab> tabs = [
    Tab(
      text: 'Agents',
    ),
    Tab(
      text: 'Ranks',
    ),
    Tab(
      text: 'Maps',
    ),
    Tab(
      text: 'Others',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
