import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/network/rank_client.dart';
import 'package:valorant_tips/widgets/rank_screen/ranks_list.dart';

import '../models/rank.dart';

class RanksScreen extends StatefulWidget {
  const RanksScreen({Key? key}) : super(key: key);

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  final RankClient _rankClient = RankClient();

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
            padding: EdgeInsets.only(left: 20.w),
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
                return RanksList(snapshot: snapshot);
              },
          ),
        ],
      ),
    ));
  }
}
