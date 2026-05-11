import 'dart:async';
import 'dart:ui';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/durations.dart';
import 'package:core/constants/gaps.dart';
import 'package:core/logger/product_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen/gen.dart';
import 'package:theme_module/theme_module.dart';

class VideoItem {
  const VideoItem({required this.label, required this.url});
  final String label;
  final String url;
}

class ProductVideoSheet extends StatefulWidget {
  const ProductVideoSheet({required this.items, required this.initialIndex, super.key});

  final List<VideoItem> items;
  final int initialIndex;

  static Future<void> show(BuildContext context, {required List<VideoItem> items, int initialIndex = 0}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: AppDurations.ms300,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      pageBuilder: (context, _, _) => ProductVideoSheet(items: items, initialIndex: initialIndex),
    );
  }

  @override
  State<ProductVideoSheet> createState() => _ProductVideoSheetState();
}

class _ProductVideoSheetState extends State<ProductVideoSheet> {
  late BetterPlayerController _controller;
  late int _selectedIndex;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: false,
          enableOverflowMenu: false,
          enableFullscreen: false,
        ),
      ),
    );
    _controller.addEventsListener(_onPlayerEvent);
    unawaited(_setupVideo(widget.items[_selectedIndex].url));
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky));
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
      ProductLogger.e('Video playback failed: ${event.parameters}', tag: 'ProductVideoSheet');
      if (mounted) setState(() => _hasError = true);
    }
  }

  Future<void> _setupVideo(String url) async {
    setState(() => _hasError = false);
    await _controller.setupDataSource(BetterPlayerDataSource(BetterPlayerDataSourceType.network, url));
  }

  void _onChipSelected(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    unawaited(_setupVideo(widget.items[index].url));
  }

  @override
  void dispose() {
    _controller.removeEventsListener(_onPlayerEvent);
    _controller.dispose();
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: CustomWidgetDimensions.videoSheetBlurSigma,
                  sigmaY: CustomWidgetDimensions.videoSheetBlurSigma,
                ),
                child: Container(color: context.colorScheme.scrim.withValues(alpha: 0.5)),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _CloseButtonRow(onClose: () => Navigator.pop(context)),
                const Spacer(),
                _VideoArea(controller: _controller, hasError: _hasError),
                Gaps.g16,
                if (widget.items.length > 1)
                  _ChipSelector(items: widget.items, selectedIndex: _selectedIndex, onSelected: _onChipSelected),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseButtonRow extends StatelessWidget {
  const _CloseButtonRow({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.k16),
        child: GestureDetector(
          onTap: onClose,
          child: Container(
            width: CustomWidgetDimensions.videoSheetCloseButtonSize,
            height: CustomWidgetDimensions.videoSheetCloseButtonSize,
            decoration: BoxDecoration(
              color: context.colorScheme.surface.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close, color: context.colorScheme.onSurface, size: Dimensions.k20),
          ),
        ),
      ),
    );
  }
}

class _VideoArea extends StatelessWidget {
  const _VideoArea({required this.controller, required this.hasError});
  final BetterPlayerController controller;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            LocaleKeys.weapons_skins_noVideo.tr(),
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: controller),
    );
  }
}

class _ChipSelector extends StatelessWidget {
  const _ChipSelector({required this.items, required this.selectedIndex, required this.onSelected});
  final List<VideoItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.k40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
        itemCount: items.length,
        separatorBuilder: (_, _) => Gaps.g8,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16, vertical: Dimensions.k8),
              decoration: BoxDecoration(
                color: isSelected ? context.colorScheme.primary : context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(Dimensions.borderRadius),
              ),
              alignment: Alignment.center,
              child: Text(
                items[index].label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
