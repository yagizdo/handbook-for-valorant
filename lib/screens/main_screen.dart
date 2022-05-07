import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<Widget> tabs = [
    const Text(
      'Agents',
    ),
    const Text(
      'Ranks',
    ),
    const Text(
      'Maps',
    ),
    const Text(
      'Others',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        screens: tabs,
        items: [
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.home), title: 'Agents'),
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.home), title: 'Maps'),
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.home), title: 'Ranks'),
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.home), title: 'Others'),
        ],
      ),
    );
  }
}
