import 'dart:math';

import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/constants/weapon_damage_colors.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_stats_model.dart';
import 'package:theme_module/theme_module.dart';

class WeaponDamageSection extends StatelessWidget {
  const WeaponDamageSection({required this.damageRanges, super.key});
  final List<DamageRangeModel> damageRanges;

  @override
  Widget build(BuildContext context) {
    if (damageRanges.isEmpty) return const SizedBox.shrink();

    final colorScheme = context.colorScheme;
    final maxHead = damageRanges.map((r) => r.headDamage ?? 0).reduce(max);
    final maxBody = damageRanges.map((r) => r.bodyDamage ?? 0).reduce(max);
    final maxLeg = damageRanges.map((r) => r.legDamage ?? 0).reduce(max);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Dimensions.borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _DamageHeaderRow(colorScheme: colorScheme),
          ...damageRanges.map(
            (range) => _DamageDataRow(
              range: range,
              maxHead: maxHead,
              maxBody: maxBody,
              maxLeg: maxLeg,
              colorScheme: colorScheme,
            ),
          ),
        ],
      ),
    );
  }
}

class _DamageHeaderRow extends StatelessWidget {
  const _DamageHeaderRow({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme.primary.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12, vertical: Dimensions.k8),
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Text(
              LocaleKeys.weapons_damage_range.tr(),
              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(
              LocaleKeys.weapons_damage_head.tr(),
              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(
              LocaleKeys.weapons_damage_body.tr(),
              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(
              LocaleKeys.weapons_damage_leg.tr(),
              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _DamageDataRow extends StatelessWidget {
  const _DamageDataRow({
    required this.range,
    required this.maxHead,
    required this.maxBody,
    required this.maxLeg,
    required this.colorScheme,
  });

  final DamageRangeModel range;
  final double maxHead;
  final double maxBody;
  final double maxLeg;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final rangeText = '${range.rangeStartMeters?.toInt() ?? 0}-${range.rangeEndMeters?.toInt() ?? 0}m';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12, vertical: Dimensions.k8),
      child: Row(
        children: [
          Expanded(flex: 12, child: Text(rangeText, style: context.textTheme.bodySmall)),
          Expanded(
            flex: 10,
            child: _DamageCell(
              damage: range.headDamage,
              maxDamage: maxHead,
              barColor: colorScheme.primary,
              isHead: true,
            ),
          ),
          Expanded(
            flex: 10,
            child: _DamageCell(damage: range.bodyDamage, maxDamage: maxBody, barColor: WeaponDamageColors.bodyDamage),
          ),
          Expanded(
            flex: 10,
            child: _DamageCell(damage: range.legDamage, maxDamage: maxLeg, barColor: WeaponDamageColors.legDamage),
          ),
        ],
      ),
    );
  }
}

class _DamageCell extends StatelessWidget {
  const _DamageCell({required this.damage, required this.maxDamage, required this.barColor, this.isHead = false});

  final double? damage;
  final double maxDamage;
  final Color barColor;
  final bool isHead;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final displayDamage = damage ?? 0;
    final ratio = maxDamage > 0 ? displayDamage / maxDamage : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatDamage(damage),
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: isHead ? FontWeight.bold : null,
            color: isHead ? colorScheme.primary : null,
          ),
        ),
        Gaps.g4,
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: CustomWidgetDimensions.weaponDamageBarHeight,
              width: constraints.maxWidth * ratio,
              decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(Dimensions.k2)),
            );
          },
        ),
      ],
    );
  }

  String _formatDamage(double? damage) {
    if (damage == null) return '-';
    if (damage == damage.roundToDouble()) return damage.toInt().toString();
    return damage.toStringAsFixed(1);
  }
}
