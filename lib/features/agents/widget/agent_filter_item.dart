import 'package:core/constants/dimensions.dart';
import 'package:core/constants/durations.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class AgentFilterItem extends StatelessWidget {
  const AgentFilterItem({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: AppDurations.ms200,
              curve: Curves.easeInOut,
              style: (context.textTheme.labelMedium ?? const TextStyle()).copyWith(
                color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 1.0,
              ),
              child: Text(label.toUpperCase()),
            ),
            Gaps.g4,
            AnimatedContainer(
              duration: AppDurations.ms200,
              curve: Curves.easeInOut,
              width: isSelected ? Dimensions.k20 : Dimensions.k0,
              height: CustomWidgetDimensions.agentFilterIndicatorHeight,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(Dimensions.k2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
