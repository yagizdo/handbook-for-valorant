import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/ranks/constants/rank_color_constants.dart';
import 'package:handbook_for_valorant/features/ranks/model/rank_model.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_module/theme_module.dart';

class RankCard extends StatelessWidget {
  const RankCard({required this.rank, super.key});
  final RankModel rank;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        RankColorConstants.rankColors[rank.division?.toLowerCase()] ?? context.colorScheme.surfaceContainerHighest;

    return Container(
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(Dimensions.borderRadius),
      ),
      padding: const EdgeInsets.all(Dimensions.k8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Skeleton.replace(
              child: rank.largeIcon != null && rank.largeIcon!.isNotEmpty
                  ? ProductImage.network(path: rank.largeIcon!, fit: BoxFit.contain, showError: false)
                  : const SizedBox.shrink(),
            ),
          ),
          Gaps.g4,
          Text(
            rank.tierName ?? '',
            style: context.textTheme.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
