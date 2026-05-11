import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/model/weapon_stats_model.dart';
import 'package:theme_module/theme_module.dart';

class WeaponStatsSection extends StatelessWidget {
  const WeaponStatsSection({required this.stats, super.key});
  final WeaponStatsModel? stats;

  @override
  Widget build(BuildContext context) {
    if (stats == null) return const SizedBox.shrink();

    final colorScheme = context.colorScheme;

    final statItems = <_StatItem>[
      if (stats!.fireRate != null) _StatItem(LocaleKeys.weapons_stats_fireRate.tr(), _formatStat(stats!.fireRate)),
      if (stats!.magazineSize != null) _StatItem(LocaleKeys.weapons_stats_magazine.tr(), '${stats!.magazineSize}'),
      if (stats!.reloadTimeSeconds != null)
        _StatItem(LocaleKeys.weapons_stats_reloadTime.tr(), '${_formatStat(stats!.reloadTimeSeconds)}s'),
      if (stats!.wallPenetration != null)
        _StatItem(LocaleKeys.weapons_stats_wallPenetration.tr(), _formatWallPenetration(stats!.wallPenetration!)),
      if (stats!.equipTimeSeconds != null)
        _StatItem(LocaleKeys.weapons_stats_equipTime.tr(), '${_formatStat(stats!.equipTimeSeconds)}s'),
      if (stats!.firstBulletAccuracy != null)
        _StatItem(LocaleKeys.weapons_stats_firstBulletAcc.tr(), _formatStat(stats!.firstBulletAccuracy)),
    ];

    if (statItems.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: Dimensions.k12,
      runSpacing: Dimensions.k12,
      children: statItems.map((item) {
        return SizedBox(
          width: (MediaQuery.sizeOf(context).width - Dimensions.k16 * 2 - Dimensions.k12) / 2,
          child: Container(
            padding: const EdgeInsets.all(Dimensions.k12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(Dimensions.borderRadius),
              border: Border(
                left: BorderSide(color: colorScheme.primary, width: CustomWidgetDimensions.weaponStatAccentBorderWidth),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: context.textTheme.labelSmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.g2,
                Text(item.value, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatWallPenetration(String value) {
    final index = value.lastIndexOf('::');
    return index != -1 ? value.substring(index + 2) : value;
  }

  String _formatStat(double? value) {
    if (value == null) return '-';
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toStringAsFixed(2);
  }
}

class _StatItem {
  const _StatItem(this.label, this.value);
  final String label;
  final String value;
}
