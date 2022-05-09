import 'package:flutter/material.dart';
import 'package:valorant_tips/models/agent.dart';
import 'package:valorant_tips/widgets/agents_screen/Ability/abilities_card.dart';

class AbiliityList extends StatefulWidget {
  AbiliityList({Key? key, required this.abilityList}) : super(key: key);
  List<Abilities> abilityList;

  @override
  State<AbiliityList> createState() => _AbiliityListState();
}

class _AbiliityListState extends State<AbiliityList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.abilityList.length,
      itemBuilder: (BuildContext context, int index) {
        // Abilities Card
        return AbilitiesCard(
            agentAbilities: widget.abilityList[index],
            abilitiesLenght: widget.abilityList.length,
            selected: selectedIndex == index ? true : false);
      },
    );
  }
}
