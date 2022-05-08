import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/models/agent.dart';

class AgentsCard extends StatelessWidget {
  AgentsCard({Key? key, required this.agent}) : super(key: key);

  Agent agent;

  @override
  Widget build(BuildContext context) {
    var agentColors = [Colors.blueGrey,
      Colors.red,
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: agentColors,
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          agent.fullPortraitV2!,
          fit: BoxFit.cover,
          cacheHeight: 200,
        ),
      ),
    );
  }
}
