import 'package:flutter/material.dart';
import 'package:valorant_tips/models/weapon.dart';
import 'package:valorant_tips/network/weapon_client.dart';
import 'package:valorant_tips/widgets/weapon_screen/weapon_list.dart';

class WeaponScreen extends StatefulWidget {
  const WeaponScreen({Key? key}) : super(key: key);

  @override
  State<WeaponScreen> createState() => _WeaponScreenState();
}

class _WeaponScreenState extends State<WeaponScreen> {
  // Weapons Client
  final WeaponsClient _weaponsClient = WeaponsClient();

  // Weapons List
  late Future<Iterable<Weapon>> _weapons;
  @override
  void initState() {
   _weapons = _weaponsClient.getWeapons();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<Iterable<Weapon>>(
            future: _weapons,
            builder: (
                BuildContext context,
                AsyncSnapshot<Iterable<Weapon>> snapshot,
                ) {
              return WeaponsList(snapshot: snapshot);
            },
          ),
        ],
      ),
    );
  }
}
