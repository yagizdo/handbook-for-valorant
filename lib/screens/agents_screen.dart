import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/network/agent_client.dart';

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
    agents = _agentClient.getAgents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Iterable<Agent>>(
          future: agents,
          builder: (
            BuildContext context,
            AsyncSnapshot<Iterable<Agent>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 2 / 2),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data!.toList();
                      return Column(
                        children: [
                          Image.network(data[index].displayIcon ?? data[index].displayIcon!,width: 150,),
                          Text(data[index].displayName!,style: TextStyle(color: white),),
                        ],
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
        ));
  }
}
