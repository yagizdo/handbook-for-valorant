import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../models/weapon.dart';

class WeaponSectionOne extends StatelessWidget {
  WeaponSectionOne({Key? key,required this.weapon}) : super(key: key);

  Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: black_second,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Column(
            children: [
              // First Section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 15.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('KILLFEED ICON',style: TextStyle(color: white,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.h,),

                      // I just used substring to get the last part.
                      // Because one thing that comes: "EEquippableCategory::Rifle"
                      CachedNetworkImage(width: weapon.displayName == 'Frenzy' ? 60.w : 70.w,imageUrl: weapon.killStreamIcon ?? 'https://cdn.iconscout.com/icon/free/png-256/data-not-found-1965034-1662569.png',),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CATEGORY',style: TextStyle(color: white,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.h,),
                      // I just used substring to get the last part.
                      // Because one thing that comes: "EEquippableCategory::Rifle"
                      Text(weapon.category?.substring(21) ?? 'No Data',style: TextStyle(color: white),),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('WALL DAMAGE',style: TextStyle(color: white,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.h,),
                      // I just used substring to get the last part.
                      // Because one thing that comes: "EEquippableCategory::Rifle"
                      Text(weapon.weaponStats?.wallPenetration?.substring(29) ?? 'No Data',style: TextStyle(color: white),),
                    ],
                  ),
                  SizedBox(width: 10.w,),
                ],
              ),
              // For space
              SizedBox(height: 40.h,),

              // Second Section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 15.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('FIRE RATE',style: TextStyle(color: white,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.h,),

                      // I just used substring to get the last part.
                      // Because one thing that comes: "EEquippableCategory::Rifle"
                      Text('${weapon.weaponStats?.fireRate ?? 'No Data'} / Sec',style: TextStyle(color: white),),
                    ],
                  ),
                  SizedBox(width: 50.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RELOAD SPEED',style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize: 10.sp)),
                      SizedBox(height: 5.h,),
                      // I just used substring to get the last part.
                      // Because one thing that comes: "EEquippableCategory::Rifle"
                      Text('${weapon.weaponStats?.reloadTimeSeconds ?? 'No Data'} / Sec',style: TextStyle(color: white),),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('EQUIP SPEED',style: TextStyle(color: white,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.h,),
                      // I just used substring to get the last part.
                      // Because one thing that comes: "EEquippableCategory::Rifle"
                      Text(weapon.weaponStats?.wallPenetration?.substring(29) ?? 'No Data',style: TextStyle(color: white),),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
