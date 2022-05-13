import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/models/map.dart';

import '../../constants/app_colors.dart';

class MapsDetail extends StatelessWidget {
  MapsDetail({Key? key, required this.mapInfo}) : super(key: key);
  Maps mapInfo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 25.h),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.h,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(mapInfo.displayName!,style: TextStyle(color: white,fontFamily: 'Valorant',fontSize: 30.sp),),
            ),
            Container(
              width: 1.sw,
              height: 0.255.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: CachedNetworkImageProvider(mapInfo.splash!))
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.h,top: 20.h),
              child: Text('Minimap',style: TextStyle(color: white,fontFamily: 'Valorant',fontSize: 30.sp),),
            ),
            Container(
              alignment: Alignment.center,
                child: mapInfo.displayIcon == null ? Text('No Minimap data',style: TextStyle(color: white,fontSize: 30.sp)) : CachedNetworkImage(
              imageUrl: mapInfo.displayIcon!,
              height: 300.w,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
