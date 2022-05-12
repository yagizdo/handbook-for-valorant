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
          title: Text(
            mapInfo.displayName!,
            style: TextStyle(fontSize: 20.sp),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
                child: mapInfo.displayIcon == null ? Text('No Minimap data',style: TextStyle(color: white,fontSize: 30.sp)) : CachedNetworkImage(
              imageUrl: mapInfo.displayIcon!,
              height: 300.w,
            ),),
          ],
        ),
      ),
    );
  }
}
