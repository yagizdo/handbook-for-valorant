import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/models/agent.dart';
import 'package:valorant_tips/widgets/agents_screen/Ability/abilities_card.dart';
import 'package:valorant_tips/widgets/agents_screen/Ability/ability_info_card.dart';

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
    return SafeArea(
      minimum: EdgeInsets.only(top: 30.h),
      child: Column(
        children: [
          const Text('ABILITIES',style: TextStyle(fontFamily: 'Valorant',color: white,fontSize: 20),),
          SizedBox(
            height: 70.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.abilityList.length,
              itemBuilder: (BuildContext context, int index) {
                // Abilities Card
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      // Update selected Index
                      selectedIndex = index;
                    });
                  },
                  child: AbilitiesCard(
                      agentAbilities: widget.abilityList[index],
                      abilitiesLenght: widget.abilityList.length,
                      selected: selectedIndex == index ? true : false),
                );
              },
            ),
          ),

          // For top padding
          SizedBox(height: 10.h,),
          AbilityInfoCard(ability: widget.abilityList[selectedIndex],),
        ],
      ),
    );
  }
}
