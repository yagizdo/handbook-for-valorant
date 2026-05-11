import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

/// A circular semi-transparent back button for detail views.
///
/// Returns a [Material] widget — callers are responsible for positioning
/// (e.g. wrapping in [Positioned] inside a [Stack]).
class ProductBackButton extends StatelessWidget {
  const ProductBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.scrim.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final didPop = await context.router.maybePop();
          if (!didPop && context.mounted) {
            context.router.popUntilRoot();
          }
        },
        child: SizedBox(
          width: CustomWidgetDimensions.backButtonSize,
          height: CustomWidgetDimensions.backButtonSize,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.colorScheme.onPrimary,
            size: CustomWidgetDimensions.backButtonIconSize,
          ),
        ),
      ),
    );
  }
}
