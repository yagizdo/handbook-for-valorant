import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/agent.dart';

class AbilityInfoCard extends StatelessWidget {
  AbilityInfoCard({Key? key,required this.ability}) : super(key: key);
  Abilities ability;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
            color: CupertinoColors.systemGrey,
            borderRadius: BorderRadius.circular(10)
        ),
        width: 1.sw,
        height: 0.25.sh,
        //padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Padding(
          padding: EdgeInsets.only(top: 20.h,left: 10.w,right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ability name and ability button
              Text('${ability.slot! == 'Ability1' ? 'Q -' : ability.slot == 'Ability2' ? 'E -' : ability.slot == 'Grenade'  ? 'C -': 'X -'} ' + ability.displayName!,style: TextStyle(fontSize: 16.sp),),
              SizedBox(height: 10.h,),
              Text(ability.description!,textAlign: TextAlign.start,style: TextStyle(fontSize: 14.sp),),
            ],
          ),
        ),
      ),
    );
  }
}
