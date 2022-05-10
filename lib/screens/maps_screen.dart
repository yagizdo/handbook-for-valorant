import 'package:flutter/material.dart';
import 'package:valorant_tips/models/map.dart';
import 'package:valorant_tips/network/maps_client.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  MapsClient mapsClient = MapsClient();

  late Future<Iterable<Maps>> maps;
  @override
  void initState() {
    maps = mapsClient.getlAllMaps();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('Maps'),
      )),
    );
  }
}
