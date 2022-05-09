import 'package:flutter/material.dart';
import 'package:valorant_tips/models/agent.dart';
import 'package:valorant_tips/widgets/agents_screen/Ability/abilities_card.dart';

class AbiliityList extends StatelessWidget {
  AbiliityList({Key? key,required this.abilityList,required this.selectedIndex}) : super(key: key);
  List<Abilities> abilityList;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: abilityList.length, itemBuilder: (BuildContext context, int index) {
      return AbilitiesCard(agentAbilities: abilityList[index], abilitiesLenght: abilityList.length, selected: selectedIndex = index ? true : false);
    },);
  }
}
