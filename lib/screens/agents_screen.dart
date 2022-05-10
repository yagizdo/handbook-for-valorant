import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/network/agent_client.dart';
import 'package:valorant_tips/widgets/agents_screen/Agent/agent_list.dart';
import 'package:valorant_tips/widgets/agents_screen/Agent/agents_card.dart';

import '../models/agent.dart';
import '../network/api_client.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  // Agent Client
  AgentClient _agentClient = AgentClient();
  // Agents List
  late Future<Iterable<Agent>> agents;
  // Agent Filter List
  var agentFilters = [
    'All',
    'Duelist',
    'Sentinels',
    'Initiators',
    'Controllers',
  ];

  // Filtred Agents
  late Iterable<Agent> filtredAgentList;

  @override
  void initState() {
    // Agent list
    agents = _agentClient.getAgents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 13.w),
              child: const Text(
                'Agents',
                style: TextStyle(
                    color: white, fontSize: 30, fontFamily: 'Valorant'),
                textAlign: TextAlign.start,
              ),
            ),

            // Agent Filters
            Expanded(
              flex: 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: agentFilters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CupertinoColors.systemRed),
                      width: 100.w,
                      alignment: Alignment.center,
                      child: Text(
                        agentFilters[index],
                        style: TextStyle(color: white, fontFamily: 'Valorant'),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Agents
            Expanded(
              flex: 13,
              child: FutureBuilder<Iterable<Agent>>(
                future: agents,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Iterable<Agent>> snapshot,
                ) {
                  return AgentList(
                    snapshot: snapshot,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
