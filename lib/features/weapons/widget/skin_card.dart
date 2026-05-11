import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/weapons/model/skin_model.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:theme_module/theme_module.dart';

class SkinCard extends StatelessWidget {
  const SkinCard({required this.skin, this.onTap, super.key});
  final SkinModel skin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: CustomWidgetDimensions.skinCardWidth,
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Dimensions.borderRadius),
            border: Border.all(color: context.colorScheme.outline.withValues(alpha: 0.2)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.k8),
                  child: skin.displayIcon != null
                      ? ProductImage.network(path: skin.displayIcon!, fit: BoxFit.contain)
                      : const SizedBox.shrink(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.k8, 0, Dimensions.k8, Dimensions.k8),
                child: Text(
                  skin.displayName,
                  style: context.textTheme.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
