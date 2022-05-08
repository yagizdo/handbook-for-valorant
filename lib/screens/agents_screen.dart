import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/network/agent_client.dart';
import 'package:valorant_tips/widgets/agents_screen/agents_card.dart';

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
              padding: EdgeInsets.only(top: 40.h,left: 13.w),
              child: const Text('Choose Your \nAgent',style: TextStyle(color: white,fontSize: 30),textAlign: TextAlign.start,),
            ),
            Expanded(
              child: FutureBuilder<Iterable<Agent>>(
                future: agents,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Iterable<Agent>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data!.toList();
                            var abilitiesList = data[index].abilities;
                            //late String? abilitiesName;
                            //abilitiesList!.forEach((element) { print('value : ${element.displayName}'); abilitiesName = element.slot; });

                            // Agent Card
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                              child: AgentsCard(agent: data[index],),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
