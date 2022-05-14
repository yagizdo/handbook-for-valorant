import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/network/rank_client.dart';

import '../models/rank.dart';

class RanksScreen extends StatefulWidget {
  const RanksScreen({Key? key}) : super(key: key);

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  RankClient _rankClient = RankClient();

  List<String> rankColors = [
    // Iron Rank Color
    '#72787A',
    '#72787A',
    '#72787A',
    // Bronze Rank Color
    '#8C7344',
    '#8C7344',
    '#8C7344',
    // Silver Rank Color
    '#818481',
    '#818481',
    '#818481',
    // Gold Rank Color
    '#E7BD42',
    '#E7BD42',
    '#E7BD42',
    // Platinum Rank Color
    '#39A5B2',
    '#39A5B2',
    '#39A5B2',
    // Diamond Rank Color
    '#D985EA',
    '#D985EA',
    '#D985EA',
    // Immortal Rank Color
    '#BD3D66',
    '#BD3D66',
    '#BD3D66',
    // Radiant Rank Color
    '#F7E19A',
  ];

  late Future<Iterable<Rank>> _ranks;
  @override
  void initState() {
    _ranks = _rankClient.getAllRanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.only(top: 50.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Text(
              'Competetive Tiers',
              style: TextStyle(
                  color: white, fontFamily: 'Valorant', fontSize: 20.sp),
            ),
          ),
          FutureBuilder<Iterable<Rank>>(
              future: _ranks,
              builder: (
                BuildContext context,
                AsyncSnapshot<Iterable<Rank>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SizedBox(
                          height: 100.h,
                          width: 50.w,
                          child: const CircularProgressIndicator()));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Flexible(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          // Burda - 3 deme sebebim ; Asagida da 3 index onden baslattigimiz icin burda da 3 index onden baslatmazsak
                          // range hatasi aliriz bu yuzden burda ki lenght den de 3 cikardim
                          itemCount:
                              snapshot.data!.toList()[3].tiers!.length - 3,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.toList();
                            // Burda index + 3 deme sebebim en basta unranked + 2 tane gereksiz rank geliyordu.
                            // Bu gereksizleri onlemek icin + 3 diyerek ana ranklari aldim
                            return Padding(
                              padding: EdgeInsets.all(13.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor(rankColors[index]),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CachedNetworkImage(
                                      width: 50.w,
                                        imageUrl: data[3]
                                                .tiers![index + 3]
                                                .smallIcon ??
                                            'https://via.placeholder.com/150'),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      snapshot.data!
                                          .toList()[3]
                                          .tiers![index + 3]
                                          .tierName!,
                                      style: TextStyle(
                                          color: snapshot.data!
                                              .toList()[3]
                                              .tiers![index + 3]
                                              .tierName! == 'RADIANT' ? black : white, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
        ],
      ),
    ));
  }
}
