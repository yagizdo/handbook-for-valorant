import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      builder: (child) => MaterialApp(
        title: 'Valo Guide',
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
        theme: AppTheme().valoTheme,
      ),
    );
  }
}
