import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../maps_screen/maps_card.dart';

class WeaponsList extends StatelessWidget {
  WeaponsList({Key? key,required this.snapshot}) : super(key: key);
  var snapshot;
  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: SizedBox(height:100.h,width:50.w,child: const CircularProgressIndicator()));
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        return Expanded(
          child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.toList();
                return Padding(padding: EdgeInsets.all(10),child: Container(color: Colors.white,alignment: Alignment.center,child: Text(
                    data[index].displayName ?? 'No Weapon Data'),));
              }),
        );
      } else {
        return const Text('Empty data');
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }
  }
