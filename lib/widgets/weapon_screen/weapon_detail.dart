import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_assets.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/widgets/weapon_screen/weapon_detail/weapon_info.dart';
import 'package:valorant_tips/widgets/weapon_screen/weapon_detail/weapon_section_one.dart';

import '../../models/weapon.dart';

class WeaponDetail extends StatelessWidget {
  WeaponDetail({Key? key, required this.weapon}) : super(key: key);
  Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 25.h),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            WeaponInfo(weapon: weapon),
            WeaponSectionOne(weapon: weapon),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: black_second,
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      // Damage Text
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, right: 270.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'DAMAGE',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '0-15m',
                              style: TextStyle(color: white),
                            ),
                          ],
                        ),
                      ),

                      // Human Body
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, left: 40.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets().human_full,
                              width: 90.h,
                            ),
                          ],
                        ),
                      ),

                      // Head Damage
                      Positioned(
                        left: 105.w,
                        child: Row(
                          children: [
                            Text(
                              '----- ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'HEAD',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  weapon.displayName == 'Vandal' || weapon.displayName == 'Bulldog' || weapon.displayName == 'Sherrif' || weapon.displayName == 'Operator' || weapon.displayName == 'Guardian' || weapon.displayName == 'Marshal' ?
                                  Text(
                                    '${weapon.weaponStats?.damageRanges?[0].headDamage ?? 'No Data'}',
                                    style: TextStyle(color: Colors.white),
                                  ) : Text(
                            '${weapon.weaponStats?.damageRanges?[1].headDamage ?? 'No Data'}',
                            style: TextStyle(color: Colors.white),
                      )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // Body Damage
                      Positioned(
                        top: 50.h,
                        left: 115.w,
                        child: Row(
                          children: [
                            Text(
                              '--- ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BODY',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  weapon.displayName == 'Vandal' || weapon.displayName == 'Bulldog' || weapon.displayName == 'Sherrif' || weapon.displayName == 'Operator' || weapon.displayName == 'Guardian' || weapon.displayName == 'Marshal' ?
                                  Text(
                                    '${weapon.weaponStats?.damageRanges![0].bodyDamage ?? 'No Data'}',
                                    style: TextStyle(color: Colors.white),
                                  ) : Text(
                                    '${weapon.weaponStats?.damageRanges![1].bodyDamage ?? 'No Data'}',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // Legs Damage
                      Positioned(
                        top: 130.h,
                        left: 115.w,
                        child: Row(
                          children: [
                            Text(
                              '--- ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LEGS',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  weapon.displayName == 'Vandal' || weapon.displayName == 'Bulldog' || weapon.displayName == 'Sherrif' || weapon.displayName == 'Operator' || weapon.displayName == 'Guardian' || weapon.displayName == 'Marshal' ?
                                  Text(
                                    '${weapon.weaponStats?.damageRanges?[0].legDamage ?? 'No Data'}',
                                    style: TextStyle(color: Colors.white),
                                  ) : Text(
                                    '${weapon.weaponStats?.damageRanges?[1].legDamage ?? 'No Data'}',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
