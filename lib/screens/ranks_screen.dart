import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/network/rank_client.dart';

import '../models/rank.dart';

class RanksScreen extends StatefulWidget {
  const RanksScreen({Key? key}) : super(key: key);

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
RankClient _rankClient = RankClient();

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
          child: FutureBuilder<Iterable<Rank>>(
            future: _ranks,
            builder: (
                BuildContext context,
                AsyncSnapshot<Iterable<Rank>> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SizedBox(height:100.h,width:50.w,child: const CircularProgressIndicator()));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                      // Burda - 3 deme sebebim ; Asagida da 3 index onden baslattigimiz icin burda da 3 index onden baslatmazsak
                      // range hatasi aliriz bu yuzden burda ki lenght den de 3 cikardim
                      itemCount: snapshot.data!.toList()[3].tiers!.length - 3,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.toList();
                        // Burda index + 3 deme sebebim en basta unranked + 2 tane gereksiz rank geliyordu.
                        // Bu gereksizleri onlemek icin + 3 diyerek ana ranklari aldim
                        return CachedNetworkImage(imageUrl: data[3].tiers![index + 3].smallIcon ?? 'https://via.placeholder.com/150');
                      });
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
          )
    );
  }
}
