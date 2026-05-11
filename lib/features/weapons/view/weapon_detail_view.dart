import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_model.dart';
import 'package:handbook_for_valorant/features/weapons/widget/skins_list.dart';
import 'package:handbook_for_valorant/features/weapons/widget/weapon_damage_section.dart';
import 'package:handbook_for_valorant/features/weapons/widget/weapon_stats_section.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button_overlay.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:handbook_for_valorant/product/widgets/product_scaffold.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class WeaponDetailView extends StatelessWidget {
  const WeaponDetailView({required this.weapon, super.key});

  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    return ProductScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WeaponHeader(weapon: weapon),
                _WeaponInfo(weapon: weapon),
                _WeaponContentSections(weapon: weapon),
                SizedBox(height: MediaQuery.paddingOf(context).bottom + Dimensions.k32),
              ],
            ),
          ),
          const ProductBackButtonOverlay(),
        ],
      ),
    );
  }
}

class _WeaponHeader extends StatelessWidget {
  const _WeaponHeader({required this.weapon});
  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomWidgetDimensions.weaponDetailHeaderHeight,
      width: double.infinity,
      color: context.colorScheme.surfaceContainerHighest,
      child: weapon.displayIcon != null && weapon.displayIcon!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(Dimensions.k32),
              child: ProductImage.network(path: weapon.displayIcon!, fit: BoxFit.contain),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _WeaponInfo extends StatelessWidget {
  const _WeaponInfo({required this.weapon});
  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.k16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(weapon.displayName, style: context.textTheme.headlineMedium),
          if (weapon.shopData != null) ...[
            Gaps.g8,
            Row(
              children: [
                if (weapon.shopData!.categoryText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.k8, vertical: Dimensions.k4),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(Dimensions.borderRadius),
                    ),
                    child: Text(
                      weapon.shopData!.categoryText!,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                if (weapon.shopData!.categoryText != null && weapon.shopData!.cost != null) Gaps.g8,
                if (weapon.shopData!.cost != null)
                  Text(
                    '${weapon.shopData!.cost!} ${LocaleKeys.weapons_stats_credits.tr()}',
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _WeaponContentSections extends StatelessWidget {
  const _WeaponContentSections({required this.weapon});
  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.g8,
          _WeaponSectionHeader(title: LocaleKeys.weapons_section_stats.tr().toUpperCase()),
          Gaps.g12,
          WeaponStatsSection(stats: weapon.weaponStats),
          Gaps.g24,
          _WeaponSectionHeader(title: LocaleKeys.weapons_section_damageRanges.tr().toUpperCase()),
          Gaps.g12,
          WeaponDamageSection(damageRanges: weapon.weaponStats?.damageRanges ?? []),
          Gaps.g24,
          _WeaponSectionHeader(
            title: LocaleKeys.weapons_section_skins.tr().toUpperCase(),
            trailing: _SeeAllLink(weapon: weapon),
          ),
          Gaps.g12,
          SkinsList(weapon: weapon),
        ],
      ),
    );
  }
}

class _WeaponSectionHeader extends StatelessWidget {
  const _WeaponSectionHeader({required this.title, this.trailing});
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: CustomWidgetDimensions.weaponStatAccentBorderWidth,
          height: CustomWidgetDimensions.weaponSectionBarHeight,
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(Dimensions.k2),
          ),
        ),
        Gaps.g8,
        Expanded(
          child: Text(
            title,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.primary,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class _SeeAllLink extends StatelessWidget {
  const _SeeAllLink({required this.weapon});
  final WeaponModel weapon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(WeaponSkinsRoute(weapon: weapon)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.weapons_skins_seeAll.tr(),
            style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.primary),
          ),
          Gaps.g4,
          Icon(Icons.arrow_forward_ios_rounded, size: Dimensions.k12, color: context.colorScheme.primary),
        ],
      ),
    );
  }
}
