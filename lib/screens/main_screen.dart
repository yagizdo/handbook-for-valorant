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
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        bottom: TabBar(
          indicatorWeight: 0.001,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: tabs
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
