import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:theme_module/theme_module.dart';

class ProductError extends StatelessWidget {
  const ProductError({required this.message, super.key, this.onRetry});
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: CustomWidgetDimensions.errorIconSize, color: context.colorScheme.error),
          Gaps.g16,
          Text(message, textAlign: TextAlign.center, style: context.textTheme.bodyLarge),
          if (onRetry != null) ...[
            Gaps.g16,
            ElevatedButton(onPressed: onRetry, child: Text(LocaleKeys.common_action_retry.tr())),
          ],
        ],
      ),
    );
  }
}
