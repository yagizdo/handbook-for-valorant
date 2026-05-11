import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:core/utility/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/maps/model/map_model.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button_overlay.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:handbook_for_valorant/product/widgets/product_scaffold.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class MapDetailView extends StatelessWidget {
  const MapDetailView({required this.map, super.key});

  final MapModel map;

  @override
  Widget build(BuildContext context) {
    return ProductScaffold(body: _MapDetailContent(map: map));
  }
}

class _MapDetailContent extends StatelessWidget {
  const _MapDetailContent({required this.map});
  final MapModel map;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SplashHeader(map: map),
              _MapInfo(map: map),
              _DetailedMapImage(map: map),
              if (map.callouts.isNotEmpty) _CalloutsSection(map: map) else const _EmptyCallouts(),
              Gaps.g32,
            ],
          ),
        ),
        const ProductBackButtonOverlay(),
      ],
    );
  }
}

class _SplashHeader extends StatelessWidget {
  const _SplashHeader({required this.map});
  final MapModel map;

  @override
  Widget build(BuildContext context) {
    if (map.splash != null && map.splash!.isNotEmpty) {
      return ProductImage.network(
        // TODO : Fix null path in every feature
        path: map.splash!,
        width: context.width,
        height: CustomWidgetDimensions.mapDetailSplashHeight,
      );
    }

    return SizedBox(
      height: CustomWidgetDimensions.mapDetailSplashHeight,
      child: Container(color: context.colorScheme.surfaceContainerHighest),
    );
  }
}

class _MapInfo extends StatelessWidget {
  const _MapInfo({required this.map});
  final MapModel map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.k16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(map.displayName, style: context.textTheme.headlineMedium),
          if (map.coordinates != null) ...[
            Gaps.g4,
            Text(
              map.coordinates!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailedMapImage extends StatelessWidget {
  const _DetailedMapImage({required this.map});
  final MapModel map;

  @override
  Widget build(BuildContext context) {
    if (map.mapUrl == null || !map.mapUrl!.startsWith('http')) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.borderRadius),
        child: ProductImage.network(
          // TODO : Fix null path in every feature
          path: map.mapUrl!,
          width: context.width - Dimensions.k16 * 2,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _EmptyCallouts extends StatelessWidget {
  const _EmptyCallouts();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.k16),
      child: Text(
        LocaleKeys.maps_callout_empty.tr(),
        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _CalloutsSection extends StatelessWidget {
  const _CalloutsSection({required this.map});
  final MapModel map;

  @override
  Widget build(BuildContext context) {
    // Group callouts by superRegionName
    final grouped = <String, List<String>>{};
    for (final callout in map.callouts) {
      final superRegion = callout.superRegionName ?? LocaleKeys.maps_callout_otherRegion.tr();
      final region = callout.regionName ?? LocaleKeys.maps_callout_unknown.tr();
      grouped.putIfAbsent(superRegion, () => []).add(region);
    }

    return Padding(
      padding: const EdgeInsets.all(Dimensions.k16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.maps_section_callouts.tr().toUpperCase(), style: context.textTheme.titleMedium),
          Gaps.g12,
          ...grouped.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                Gaps.g8,
                Wrap(
                  spacing: Dimensions.k8,
                  runSpacing: Dimensions.k8,
                  children: entry.value.map((regionName) {
                    return Chip(
                      label: Text(
                        regionName,
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSecondaryContainer),
                      ),
                      backgroundColor: context.colorScheme.secondaryContainer,
                      side: BorderSide.none,
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
                Gaps.g12,
              ],
            );
          }),
        ],
      ),
    );
  }
}
