import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/maps/model/map_model.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:theme_module/theme_module.dart';

class MapCard extends StatelessWidget {
  const MapCard({required this.map, super.key});
  final MapModel map;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.push(MapDetailRoute(map: map)),
        borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
        child: SizedBox(
          height: CustomWidgetDimensions.mapCardImageHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              if (map.listViewIconTall != null && map.listViewIconTall!.isNotEmpty)
                ProductImage.network(
                  // TODO : Fix null path in every feature
                  path: map.listViewIconTall!,
                ),

              // Dark gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.scrim.withValues(alpha: 0.7),
                      context.colorScheme.scrim.withValues(alpha: 0.1),
                      context.colorScheme.scrim.withValues(alpha: 0.4),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Map name and coordinates
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.k24, vertical: Dimensions.k16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      map.displayName,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: context.colorScheme.shadow.withValues(alpha: 0.5),
                            blurRadius: CustomWidgetDimensions.mapCardShadowBlurRadius,
                          ),
                        ],
                      ),
                    ),
                    Gaps.g4,
                    Text(
                      map.coordinates ?? '',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onPrimary.withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Mini map icon (top-right)
              if (map.displayIcon != null && map.displayIcon!.isNotEmpty)
                Positioned(
                  top: Dimensions.k12,
                  right: Dimensions.k12,
                  child: ProductImage.network(
                    // TODO : Fix null path in every feature
                    path: map.displayIcon!,
                    width: CustomWidgetDimensions.miniMapIconSize,
                    height: CustomWidgetDimensions.miniMapIconSize,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
