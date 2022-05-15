import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:valorant_tips/constants/app_assets.dart';
import 'package:valorant_tips/screens/agents_screen.dart';
import 'package:valorant_tips/screens/maps_screen.dart';
import 'package:valorant_tips/screens/others_screen.dart';
import 'package:valorant_tips/screens/ranks_screen.dart';
import 'package:valorant_tips/screens/weapons_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<Widget> tabs = [
    const AgentsScreen(),
    const MapsScreen(),
    const WeaponScreen(),
    const RanksScreen(),
    const OthersScreen(),
  ];

  // Assets
  final AppAssets _appAssets = AppAssets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        navBarStyle: NavBarStyle.style15,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        screens: tabs,
        items: [
          // Agents
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              inactiveIcon: Image.asset(_appAssets.agents_icon,
                color: CupertinoColors.inactiveGray,
                width: 18.w,
              ),
              icon: Image.asset(_appAssets.agents_icon,
                width: 18.w,
              ),
              title: 'Agents'),

          // Maps
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: const Icon(Icons.map_rounded),
              title: 'Maps'),

          // Weapons
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: Image.asset(_appAssets.weapons_icon,
                width: 30.w,
              ),
              title: 'Weapons'),

          // Ranks
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: const Icon(Icons.emoji_events_outlined),
              title: 'Ranks'),

          // More
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: const Icon(Icons.more_horiz_rounded),
              title: 'More'),
        ],
      ),
    );
  }
}
