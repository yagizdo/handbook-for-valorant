import 'package:flutter/material.dart';
import 'package:valorant_tips/network/weapon_client.dart';

class WeaponScreen extends StatefulWidget {
  const WeaponScreen({Key? key}) : super(key: key);

  @override
  State<WeaponScreen> createState() => _WeaponScreenState();
}

class _WeaponScreenState extends State<WeaponScreen> {
  final WeaponsClient _weaponsClient = WeaponsClient();
  @override
  void initState() {
    print('init calisti');
    _weaponsClient.getWeapons();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
