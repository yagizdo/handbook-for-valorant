import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';

import '../../models/agent.dart';

class AgentsDetail extends StatefulWidget {
  AgentsDetail({Key? key, required this.agent}) : super(key: key);

  Agent agent;

  @override
  State<AgentsDetail> createState() => _AgentsDetailState();
}

class _AgentsDetailState extends State<AgentsDetail> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Abilities> agentAbilities = [];
    widget.agent.abilities?.forEach((element) {
      agentAbilities.add(element);
    });
    return SafeArea(
      minimum: const EdgeInsets.only(top: 30),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.agent.displayName!),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.agent.displayName!,
                        style: TextStyle(
                            color: white, fontWeight: FontWeight.w800),
                      ),
                      Text(widget.agent.role!.displayName! + ' /Agent Role',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w400)),
                      CircleAvatar(
                        backgroundColor: black,
                        backgroundImage:
                            NetworkImage(widget.agent.role!.displayIcon!),
                      ),
                      Text(widget.agent.displayName!),
                      Text(widget.agent.description!),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: agentAbilities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              agentAbilities[index].displayIcon!,
                              width: 50.w,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.tertiarySystemGroupedBackground,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(agentAbilities[selectedIndex].displayName!)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
