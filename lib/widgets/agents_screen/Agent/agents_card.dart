import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
        Color(0xFFBC542D),
        Color(0xFF58394D),
        Color(0xFFA06C45),
        Color(0xFF50785D)
      ],
      // Raze
      [
        Color(0xFFe36230),
        Color(0xFFd89e4f),
        Color(0xFF2c4446),
      ],
      // Chamber
      [
        Color(0xFF30aae1),
        Color(0xFFc83d7b),
        Color(0xFF947961),
        Color(0xFFffce6f)
      ],
      // Kay/o
      [
        Color(0xFF2bc8ff),
        Color(0xFF4343b2),
        Color(0xFF905ef6),
        Color(0xFFff89ff)
      ],
      // Skye
      [
        Color(0xFF8ea36f),
        Color(0xFF364241),
        Color(0xFFae8e4d),
        Color(0xFFaf694d)
      ],
      // Cypher
      [
        Color(0xFFd18a5b),
        Color(0xFF6097df),
        Color(0xFF48486c),
        Color(0xFF4b76cc)
      ],
      // Sova
      [
        Color(0xFFebccae),
        Color(0xFF2947c3),
        Color(0xFF997b58),
        Color(0xFF567fb5)
      ],
      // Killjoy
      [
        Color(0xFFe6d759),
        Color(0xFF58956a),
        Color(0xFFdd8df8),
        Color(0xFFf3ab3d)
      ],
      // Viper
      [
        Color(0xFF51af58),
        Color(0xFF6b8690),
        Color(0xFFa5ae60),
        Color(0xFFdef2ac)
      ],
      // Phoneix
      [
        Color(0xFFf7bf60),
        Color(0xFFea6d4e),
        Color(0xFF838ea6),
        Color(0xFF7c5b60)
      ],
      // Astra
      [
        Color(0xFFef90af),
        Color(0xFF4e26c9),
        Color(0xFF7aa1e8),
        Color(0xFFb0ae84)
      ],
      // Brimstone
      [
        Color(0xFFb35723),
        Color(0xFF8b81aa),
        Color(0xFF5f1c0a),
        Color(0xFFeb953f)
      ],
      // Neon
      [
        Color(0xFF00008b),
        Color(0xFF00FFFF),
        Color(0xFF00ffff),
        Color(0xFF00008b)
      ],
      // Yoru
      [Color(0xFFe18437), Color(0xFF99412a), Color(0xFF394278), Color(0xFF0024f5)],
      // Sage
      [Color(0xFF9254b8), Color(0xFF67abdd), Color(0xFF66357e), Color(0xFF78fad8)],
      // Reyna
      [Color(0xFFce53a8), Color(0xFF2f2664), Color(0xFF383b3d), Color(0xFFe46c76)],
      // Omen
      [Color(0xFF7c7fb4), Color(0xFF3e3c56), Color(0xFF4a5fa4), Color(0xFF59bbc5)],
      // Jett
      [Color(0xFF9edaf6), Color(0xFF5266aa), Color(0xFF2b577c), Color(0xFF90fcfd)],
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
