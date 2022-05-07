import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../api/api_client.dart';
import '../models/agent.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  ApiClient client = ApiClient();
  late Future<Iterable<Agent>> agents;

  @override
  void initState() {
    agents = client.getAgents();
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
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 2),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.toList();
                    return Text(data[index].displayName!);
                  },
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
