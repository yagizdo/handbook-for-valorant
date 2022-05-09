import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/models/agent.dart';

class AbilitiesCard extends StatelessWidget {
  AbilitiesCard({Key? key,required this.agentAbilities,required this.abilitiesLenght,required this.selected}) : super(key: key);
  Abilities agentAbilities;
  int abilitiesLenght;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
          horizontal: abilitiesLenght ==
              5 /*for jett cause shes have 5 abilities */ ? 11.5.w
              : 15.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: selected ? Colors.red : Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Image.network(
              agentAbilities.displayIcon!,
              width: 40.w,
            ),
          ),
        ),
      ),
    );
  }
}
