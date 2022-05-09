import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/widgets/agents_screen/Ability/abilities_card.dart';

import '../../../models/agent.dart';

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
    // Agent Abilities
    List<Abilities> agentAbilities = [];

    // Model to agent abilities list
    widget.agent.abilities?.forEach((element) {
      agentAbilities.add(element);
    });

    // Scaffold
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
                        style: const TextStyle(
                            color: white, fontWeight: FontWeight.w800),
                      ),
                      Text(widget.agent.role!.displayName! + ' /Agent Role',
                          style: const TextStyle(
                              color: white, fontWeight: FontWeight.w400)),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: black,
                            backgroundImage:
                                NetworkImage(widget.agent.role!.displayIcon!),
                          ),
                          CircleAvatar(
                            backgroundColor: black,
                            backgroundImage:
                                NetworkImage(widget.agent.displayIcon!),
                          ),
                        ],
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
                          child: AbilitiesCard(
                            agentAbilities: agentAbilities[index],
                            abilitiesLenght: agentAbilities.length,
                            selected: selectedIndex == index ? true : false,
                          ));
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onHorizontalDragEnd: (dragEndDetails) {
                      if (dragEndDetails.primaryVelocity! < 0) {
                        // Swipe Left //

                        // Abilities lenght = 4 fakat sacma bir bug oldugundan bir eksigine
                        // esitledim suanlik boyle sorun yok gibi
                        selectedIndex < widget.agent.abilities!.length - 1
                            ? setState(() {
                                selectedIndex += 1;
                              })
                            : print('abilities index error');
                      } else if (dragEndDetails.primaryVelocity! > 0) {
                        // Swipe Right //
                        selectedIndex < widget.agent.abilities!.length
                            ? setState(() {
                                selectedIndex != 0
                                    ? selectedIndex -= 1
                                    : selectedIndex = selectedIndex;
                              })
                            : print('abilities index error');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              CupertinoColors.destructiveRed,
                              CupertinoColors.systemYellow,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Abilities.'),
                            Text(agentAbilities[selectedIndex].displayName!)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
