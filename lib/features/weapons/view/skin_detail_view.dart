import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/weapons/model/skin_model.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button_overlay.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:handbook_for_valorant/product/widgets/product_scaffold.dart';
import 'package:handbook_for_valorant/product/widgets/video/product_video_sheet.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class SkinDetailView extends StatefulWidget {
  const SkinDetailView({required this.skin, super.key});

  final SkinModel skin;

  @override
  State<SkinDetailView> createState() => _SkinDetailViewState();
}

class _SkinDetailViewState extends State<SkinDetailView> {
  int _selectedChromaIndex = 0;

  String? get _currentDisplayIcon {
    final chromas = widget.skin.chromas;
    if (chromas.length > 1 && _selectedChromaIndex < chromas.length) {
      return chromas[_selectedChromaIndex].fullRender ?? chromas[_selectedChromaIndex].displayIcon;
    }
    return widget.skin.displayIcon;
  }

  @override
  Widget build(BuildContext context) {
    return ProductScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkinHeader(displayIcon: _currentDisplayIcon),
                _SkinInfo(skin: widget.skin),
                if (widget.skin.chromas.length > 1)
                  _ChromaSection(
                    chromas: widget.skin.chromas,
                    selectedIndex: _selectedChromaIndex,
                    onSelected: (index) => setState(() => _selectedChromaIndex = index),
                  ),
                if (widget.skin.levels.any((l) => l.streamedVideo != null)) _LevelChips(levels: widget.skin.levels),
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

class _SkinHeader extends StatelessWidget {
  const _SkinHeader({required this.displayIcon});
  final String? displayIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomWidgetDimensions.skinDetailHeaderHeight,
      width: double.infinity,
      color: context.colorScheme.surfaceContainerHighest,
      child: displayIcon != null
          ? Padding(
              padding: const EdgeInsets.all(Dimensions.k32),
              child: ProductImage.network(path: displayIcon!, fit: BoxFit.contain),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _SkinInfo extends StatelessWidget {
  const _SkinInfo({required this.skin});
  final SkinModel skin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.k16),
      child: Text(skin.displayName, style: context.textTheme.headlineMedium),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700));
  }
}

class _ChromaSection extends StatelessWidget {
  const _ChromaSection({required this.chromas, required this.selectedIndex, required this.onSelected});
  final List<ChromaModel> chromas;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: LocaleKeys.weapons_skins_chromas.tr().toUpperCase()),
          Gaps.g12,
          Wrap(
            spacing: Dimensions.k12,
            runSpacing: Dimensions.k12,
            children: List.generate(chromas.length, (index) {
              final chroma = chromas[index];
              return _ChromaCard(
                chroma: chroma,
                isSelected: index == selectedIndex,
                onTap: chroma.streamedVideo != null
                    ? () => ProductVideoSheet.show(
                        context,
                        items: [VideoItem(label: chroma.displayName ?? '', url: chroma.streamedVideo!)],
                      )
                    : () => onSelected(index),
              );
            }),
          ),
          Gaps.g24,
        ],
      ),
    );
  }
}

class _ChromaCard extends StatelessWidget {
  const _ChromaCard({required this.chroma, required this.isSelected, required this.onTap});
  final ChromaModel chroma;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: CustomWidgetDimensions.skinDetailChromaSize,
        height: CustomWidgetDimensions.skinDetailChromaSize,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(Dimensions.k6),
          border: Border.all(
            color: isSelected ? context.colorScheme.onSurface : context.colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? Dimensions.k2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.k4),
              child: ProductImage.network(path: chroma.swatch ?? chroma.displayIcon ?? chroma.fullRender ?? ''),
            ),
            if (chroma.streamedVideo != null)
              Icon(
                Icons.play_circle_filled,
                size: CustomWidgetDimensions.skinDetailChromaPlayIconSize,
                color: context.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
          ],
        ),
      ),
    );
  }
}

class _LevelChips extends StatelessWidget {
  const _LevelChips({required this.levels});
  final List<LevelModel> levels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
      child: Wrap(
        spacing: Dimensions.k8,
        runSpacing: Dimensions.k8,
        children: List.generate(levels.length, (index) {
          final level = levels[index];
          final hasVideo = level.streamedVideo != null;
          return GestureDetector(
            onTap: hasVideo
                ? () => ProductVideoSheet.show(
                    context,
                    items: [VideoItem(label: level.displayName ?? '', url: level.streamedVideo!)],
                  )
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12, vertical: Dimensions.k8),
              decoration: BoxDecoration(
                color: hasVideo ? context.colorScheme.primary : null,
                borderRadius: BorderRadius.circular(Dimensions.k24),
                border: hasVideo ? null : Border.all(color: context.colorScheme.outline.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasVideo) ...[
                    Icon(
                      Icons.play_circle_filled,
                      size: CustomWidgetDimensions.skinDetailPlayIconSize,
                      color: context.colorScheme.onPrimary,
                    ),
                    Gaps.g4,
                  ],
                  Text(
                    LocaleKeys.weapons_skins_level.tr(args: [(index + 1).toString()]),
                    style: context.textTheme.labelMedium?.copyWith(
                      fontFamily: AppTextTheme.valorantFontFamily,
                      color: hasVideo
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
