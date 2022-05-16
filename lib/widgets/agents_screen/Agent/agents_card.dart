import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valorant_tips/constants/app_colors.dart';
import 'package:valorant_tips/models/agent.dart';
import 'package:valorant_tips/widgets/agents_screen/Agent/agents_detail.dart';

class AgentsCard extends StatelessWidget {
  AgentsCard({Key? key, required this.agent, required this.index})
      : super(key: key);

  Agent agent;
  int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentsDetail(agent: agent),
          ),
        );
      },
      child: Stack(alignment: Alignment.topLeft, children: [
        // Transparent Container
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: 55.h),

            // Colored Container
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                    // Fade
                    agent.displayName!.toLowerCase() == 'fade' ? fadeColors
                        :
                    // Breach
                    agent.displayName!.toLowerCase() == 'breach' ? breachColors
                        :
                    // Raze
                    agent.displayName!.toLowerCase() == 'raze' ? razeColors
                        :
                    // Chamber
                    agent.displayName!.toLowerCase() == 'chamber' ? chamberColors
                        :
                    // Kayo
                    agent.displayName!.toLowerCase() == 'kay/o' ? kayoColors
                        :
                    // Skye
                    agent.displayName!.toLowerCase() == 'skye' ? skyeColors
                        :
                    // Cypher
                    agent.displayName!.toLowerCase() == 'cypher' ? cypherColors
                        :
                    // Sova
                    agent.displayName!.toLowerCase() == 'sova' ? sovaColors
                        :
                    // Killjoy
                    agent.displayName!.toLowerCase() == 'killjoy' ? killjoyColors
                        :
                    // Viper
                    agent.displayName!.toLowerCase() == 'viper' ? viperColors
                        :
                    // Phoneix
                    agent.displayName == 'Phoenix' ? phoneixColors
                        :
                    // Astra
                    agent.displayName!.toLowerCase() == 'astra' ? astraColors
                        :
                    // Brimstone
                    agent.displayName!.toLowerCase() == 'brimstone' ? brimstoneColors
                        :
                    // Neon
                    agent.displayName!.toLowerCase() == 'neon' ? neonColors
                        :
                    // Yoru
                    agent.displayName!.toLowerCase() == 'yoru' ? yoruColors
                        :
                    // Sage
                    agent.displayName!.toLowerCase() == 'sage' ? sageColors
                        :
                    // Reyna
                    agent.displayName!.toLowerCase() == 'reyna' ? reynaColors
                        :
                    // Omen
                    agent.displayName!.toLowerCase() == 'omen' ? omenColors
                        :
                    // Jett
                    agent.displayName!.toLowerCase() == 'jett' ? jettColors
                        :
                    [Colors.black87,
                      Colors.blueGrey,]),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              alignment: Alignment.bottomLeft,
              width: 160.w,

              // Agent info column
              child: Padding(
                padding: EdgeInsets.all(5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      agent.role!.displayName!,
                      style: TextStyle(
                          fontFamily: 'Valorant',
                          color: white,
                          fontSize: 10.sp),
                    ),
                    Text(
                      agent.displayName!,
                      style: TextStyle(
                          fontFamily: 'Valorant',
                          color: white,
                          fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Agent Image
        Positioned(child: CachedNetworkImage(imageUrl: agent.fullPortraitV2!)),
      ]),
    );
  }
}
