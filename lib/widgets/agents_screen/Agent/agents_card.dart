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
    var agentColors = [
      // Fade
      [
        Colors.black87,
        Colors.blueGrey,
      ],
      // Breach
      [
        const Color(0xFFBC542D),
        const Color(0xFF58394D),
        const Color(0xFFA06C45),
        const Color(0xFF50785D)
      ],
      // Raze
      [
        const Color(0xFFe36230),
        const Color(0xFFd89e4f),
        const Color(0xFF2c4446),
      ],
      // Chamber
      [
        const Color(0xFF30aae1),
        const Color(0xFFc83d7b),
        const Color(0xFF947961),
        const Color(0xFFffce6f)
      ],
      // Kay/o
      [
        const Color(0xFF2bc8ff),
        const Color(0xFF4343b2),
        const Color(0xFF905ef6),
        const Color(0xFFff89ff)
      ],
      // Skye
      [
        const Color(0xFF8ea36f),
        const Color(0xFF364241),
        const Color(0xFFae8e4d),
        const Color(0xFFaf694d)
      ],
      // Cypher
      [
        const Color(0xFFd18a5b),
        const Color(0xFF6097df),
        const Color(0xFF48486c),
        const Color(0xFF4b76cc)
      ],
      // Sova
      [
        const Color(0xFFebccae),
        const Color(0xFF2947c3),
        const Color(0xFF997b58),
        const Color(0xFF567fb5)
      ],
      // Killjoy
      [
        const Color(0xFFe6d759),
        const Color(0xFF58956a),
        const Color(0xFFdd8df8),
        const Color(0xFFf3ab3d)
      ],
      // Viper
      [
        const Color(0xFF51af58),
        const Color(0xFF6b8690),
        const Color(0xFFa5ae60),
        const Color(0xFFdef2ac)
      ],
      // Phoneix
      [
        const Color(0xFFf7bf60),
        const Color(0xFFea6d4e),
        const Color(0xFF838ea6),
        const Color(0xFF7c5b60)
      ],
      // Astra
      [
        const Color(0xFFef90af),
        const Color(0xFF4e26c9),
        const Color(0xFF7aa1e8),
        const Color(0xFFb0ae84)
      ],
      // Brimstone
      [
        const Color(0xFFb35723),
        const Color(0xFF8b81aa),
        const Color(0xFF5f1c0a),
        const Color(0xFFeb953f)
      ],
      // Neon
      [
        const Color(0xFF00008b),
        const Color(0xFF00FFFF),
        const Color(0xFF00ffff),
        const Color(0xFF00008b)
      ],
      // Yoru
      [
        const Color(0xFFe18437),
        const Color(0xFF99412a),
        const Color(0xFF394278),
        const Color(0xFF0024f5)
      ],
      // Sage
      [
        const Color(0xFF9254b8),
        const Color(0xFF67abdd),
        const Color(0xFF66357e),
        const Color(0xFF78fad8)
      ],
      // Reyna
      [
        const Color(0xFFce53a8),
        const Color(0xFF2f2664),
        const Color(0xFF383b3d),
        const Color(0xFFe46c76)
      ],
      // Omen
      [
        const Color(0xFF7c7fb4),
        const Color(0xFF3e3c56),
        const Color(0xFF4a5fa4),
        const Color(0xFF59bbc5)
      ],
      // Jett
      [
        const Color(0xFF9edaf6),
        const Color(0xFF5266aa),
        const Color(0xFF2b577c),
        const Color(0xFF90fcfd)
      ],
    ];
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
                    colors: agentColors[index]),
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
