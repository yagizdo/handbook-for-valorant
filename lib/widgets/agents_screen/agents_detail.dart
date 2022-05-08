import 'package:flutter/material.dart';

import '../../models/agent.dart';

class AgentsDetail extends StatelessWidget {
  AgentsDetail({Key? key,required this.agent}) : super(key: key);

  Agent agent;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 30),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(agent.displayName!),
        ),
      ),
    );
  }
}
