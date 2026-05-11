import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';
import 'package:handbook_for_valorant/features/weapons/widget/skin_card.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:theme_module/theme_module.dart';

class SkinsList extends StatelessWidget {
  const SkinsList({required this.weapon, super.key});
  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    final filteredSkins = weapon.skins.where((s) => s.displayIcon != null).toList();

    if (filteredSkins.isEmpty) return const SizedBox.shrink();

    const maxCount = CustomWidgetDimensions.skinsPreviewMaxCount;
    final displaySkins = filteredSkins.length > maxCount ? filteredSkins.sublist(0, maxCount) : filteredSkins;
    final hasMore = filteredSkins.length > maxCount;
    final remaining = filteredSkins.length - maxCount;

    return SizedBox(
      height: CustomWidgetDimensions.skinsListPreviewHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: displaySkins.length + (hasMore ? 1 : 0),
        separatorBuilder: (_, _) => Gaps.g12,
        itemBuilder: (context, index) {
          if (hasMore && index == displaySkins.length) {
            return _SeeAllCard(weapon: weapon, remainingCount: remaining);
          }
          return SkinCard(
            skin: displaySkins[index],
            onTap: () => context.router.push(SkinDetailRoute(skin: displaySkins[index])),
          );
        },
      ),
    );
  }
}

class _SeeAllCard extends StatelessWidget {
  const _SeeAllCard({required this.weapon, required this.remainingCount});
  final WeaponModel weapon;
  final int remainingCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: () => context.router.push(WeaponSkinsRoute(weapon: weapon)),
      child: SizedBox(
        width: CustomWidgetDimensions.skinCardWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(Dimensions.borderRadius),
            border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimensions.k12),
                decoration: BoxDecoration(color: colorScheme.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: colorScheme.primary,
                  size: CustomWidgetDimensions.weaponSeeAllIconSize,
                ),
              ),
              Gaps.g8,
              Text(
                LocaleKeys.weapons_skins_seeAll.tr(),
                style: context.textTheme.labelMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
              ),
              Gaps.g4,
              Text(
                LocaleKeys.weapons_skins_remaining.tr(args: [remainingCount.toString()]),
                style: context.textTheme.labelSmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
