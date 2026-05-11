import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class ProductSettingsGroup extends StatelessWidget {
  const ProductSettingsGroup({required this.label, required this.children, super.key});
  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.k4),
          child: Text(
            label.toUpperCase(),
            style: context.textTheme.titleSmall?.copyWith(color: context.colorScheme.outline, letterSpacing: 2),
          ),
        ),
        Gaps.g8,
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Dimensions.borderRadius),
          ),
          child: Column(children: _buildChildrenWithDividers(context)),
        ),
      ],
    );
  }

  List<Widget> _buildChildrenWithDividers(BuildContext context) {
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(
          Divider(
            height: 1,
            indent: CustomWidgetDimensions.settingsDividerIndent,
            color: context.colorScheme.outline.withValues(alpha: 0.15),
          ),
        );
      }
    }
    return result;
  }
}
