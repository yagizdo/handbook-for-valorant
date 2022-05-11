import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/widgets/maps_screen/maps_detail.dart';

import '../../models/map.dart';

class MapsCard extends StatelessWidget {
  MapsCard({Key? key,required this.map}) : super(key: key);
  Maps map;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MapsDetail()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 1.sw,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: CachedNetworkImageProvider(map.listViewIcon!),
              )
            ),
          ),

          Positioned(child: Text(map.displayName!,style: TextStyle(color: white,fontFamily: 'Valorant',fontSize: 20.sp),),
          )

        ],
      ),
    );
  }
}