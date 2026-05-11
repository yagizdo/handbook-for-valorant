import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:theme_module/theme_module.dart';

class WeaponCard extends StatelessWidget {
  const WeaponCard({required this.weapon, super.key});
  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.push(WeaponDetailRoute(weapon: weapon)),
        borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Weapon icon (centered)
              if (weapon.displayIcon != null && weapon.displayIcon!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(Dimensions.lg),
                  child: ProductImage.network(
                    // TODO : Fix null path in every feature
                    path: weapon.displayIcon!,
                    fit: BoxFit.contain,
                  ),
                ),

              // Dark gradient overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.colorScheme.scrim.withValues(alpha: 0.0),
                      context.colorScheme.scrim.withValues(alpha: 0.7),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),

              // Weapon name + category
              Padding(
                padding: const EdgeInsets.all(Dimensions.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weapon.displayName,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                        fontFamily: AppTextTheme.valorantFontFamily,
                        shadows: [Shadow(color: context.colorScheme.shadow.withValues(alpha: 0.5), blurRadius: 4)],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (weapon.shopData?.categoryText != null) ...[
                      Gaps.g2,
                      Text(
                        weapon.shopData!.categoryText!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onPrimary.withValues(alpha: 0.7),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Cost badge (top-right)
              if (weapon.shopData?.cost != null && weapon.shopData!.cost! > 0)
                Positioned(
                  top: Dimensions.sm,
                  right: Dimensions.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm, vertical: Dimensions.xs),
                    decoration: BoxDecoration(
                      color: context.colorScheme.scrim.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(Dimensions.borderRadius),
                    ),
                    child: Text(
                      '${weapon.shopData!.cost!}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
