import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('app_icon/android_icon.png',scale: 3,),
            Text('Something went wrong',style: TextStyle(color: white,fontSize: 20.sp),),
            SizedBox(height: 10.h,),
            Text('Please check your internet connection',style: TextStyle(color: white,fontSize: 15.sp),),
          ],
        ),
      ),
    );
  }
}
