import 'package:flutter/material.dart';
import 'package:valorant_tips/models/map.dart';

class MapsDetail extends StatelessWidget {
  MapsDetail({Key? key,required this.mapInfo}) : super(key: key);
  Maps mapInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(mapInfo.displayName ?? 'No Data'),
      ),
    );
  }
}
