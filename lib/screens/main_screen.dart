import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:valorant_tips/constants/app_colors.dart';
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
              icon: Image.asset(
                '/Users/yagizdo/Projects/valorant_tips/lib/constants/icons/agent_icon.png',
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
              icon: Image.asset(
                'lib/constants/icons/weapons_icon.png',
                width: 30.w,
              ),
              title: 'Weapons'),

          // Ranks
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 9.w,
                child: CircleAvatar(
                  backgroundColor: white,
                  backgroundImage:
                      const AssetImage('lib/constants/icons/rank_icon.png'),
                  radius: 8.w,
                ),
              ),
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
