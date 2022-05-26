import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/screens/custom_error_screen.dart';
import 'package:valorant_tips/screens/error_screen.dart';
import 'package:valorant_tips/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key,required this.internetInfo}) : super(key: key);

  var internetInfo;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      builder: (child) => MaterialApp(
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return kDebugMode ? CustomErrorScreen(errorDetails: errorDetails) : ErrorScreen(errorDetails: errorDetails,isNetworkError: false,) ;
          };
          return widget!;
        },
        title: Platform.isAndroid ?  'Guide for Valo' : 'Handbook for Valorant',
        debugShowCheckedModeBanner: false,
        // internet check
        home: internetInfo == InternetConnectionStatus.disconnected ? ErrorScreen(isNetworkError: true,) : const MainScreen(),
        theme: AppTheme().valoTheme,
      ),
    );
  }
}
