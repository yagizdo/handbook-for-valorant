import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/logger/product_logger.dart';
import 'package:core/utility/extension/context_extension.dart';
import 'package:core/utility/extension/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:theme_module/theme_module.dart';

enum ImageSource { network, file, asset }

class ProductImage extends StatelessWidget {
  const ProductImage._({
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.hidePlaceholder = false,
    this.errorWidget,
    this.showError = true,
    this.source = ImageSource.network,
    this.radius = BorderRadius.zero,
  });

  factory ProductImage.asset({
    required String path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    bool hidePlaceholder = false,
    Widget? errorWidget,
    bool showError = true,
  }) => ProductImage._(
    path: path,
    errorWidget: errorWidget,
    fit: fit,
    height: height,
    hidePlaceholder: hidePlaceholder,
    showError: showError,
    width: width,
    source: ImageSource.asset,
  );

  factory ProductImage.custom({
    required String path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    bool hidePlaceholder = false,
    Widget? errorWidget,
    bool showError = true,
  }) {
    if (path.isURL) {
      return ProductImage.network(
        path: path,
        width: width,
        height: height,
        fit: fit,
        hidePlaceholder: hidePlaceholder,
        errorWidget: errorWidget,
        showError: showError,
      );
    }
    final isFile = File(path).existsSync();
    if (isFile) {
      return ProductImage.file(
        path: path,
        width: width,
        height: height,
        fit: fit,
        hidePlaceholder: hidePlaceholder,
        errorWidget: errorWidget,
        showError: showError,
      );
    }
    return ProductImage.asset(
      path: path,
      width: width,
      height: height,
      fit: fit,
      hidePlaceholder: hidePlaceholder,
      errorWidget: errorWidget,
      showError: showError,
    );
  }

  factory ProductImage.file({
    required String path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    bool hidePlaceholder = false,
    Widget? errorWidget,
    bool showError = true,
  }) => ProductImage._(
    path: path,
    errorWidget: errorWidget,
    fit: fit,
    height: height,
    hidePlaceholder: hidePlaceholder,
    showError: showError,
    width: width,
    source: ImageSource.file,
  );

  factory ProductImage.network({
    String? path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    bool hidePlaceholder = true,
    Widget? errorWidget,
    bool showError = true,
    BorderRadiusGeometry radius = BorderRadius.zero,
  }) => ProductImage._(
    path: path,
    errorWidget: errorWidget,
    fit: fit,
    height: height,
    hidePlaceholder: hidePlaceholder,
    showError: showError,
    width: width,
    radius: radius,
  );

  final Widget? errorWidget;
  final BoxFit fit;
  final double? height;
  final bool hidePlaceholder;
  final String? path;
  final BorderRadiusGeometry radius;
  final bool showError;
  final ImageSource source;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final errorContainer = _ErrorContainer(
      height: height,
      width: width,
      showError: showError,
      errorWidget: errorWidget,
    );
    if (path?.isEmpty ?? true) return errorContainer;
    return SizedBox(
      width: width,
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final resolvedWidth = width ?? constraints.maxWidth;
          final cacheWidth = resolvedWidth.isInfinite || resolvedWidth <= 0
              ? null
              : (resolvedWidth * context.devicePixelRatio).toInt();
          return switch (source) {
            ImageSource.file => Image.file(
              File(path!),
              width: width,
              gaplessPlayback: true,
              height: height,
              cacheWidth: cacheWidth,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                if (kDebugMode) {
                  ProductLogger.e('Image load failed: $path', tag: 'ProductImage', error: error);
                }
                return errorContainer;
              },
            ),
            ImageSource.asset => Image.asset(
              path!,
              width: width,
              gaplessPlayback: true,
              height: height,
              cacheWidth: cacheWidth,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                if (kDebugMode) {
                  ProductLogger.e('Image load failed: $path', tag: 'ProductImage', error: error);
                }
                return errorContainer;
              },
            ),
            ImageSource.network => switch (radius == BorderRadius.zero) {
              true => CachedNetworkImage(
                imageUrl: path!,
                cacheKey: path!.baseUrl,
                width: width,
                height: height,
                memCacheWidth: cacheWidth,
                fit: fit,
                placeholder: (context, url) =>
                    hidePlaceholder ? const SizedBox.shrink() : const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  if (kDebugMode) {
                    ProductLogger.e('Image load failed: $url', tag: 'ProductImage', error: error);
                  }
                  return errorContainer;
                },
              ),
              false => ClipRRect(
                borderRadius: radius,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: CachedNetworkImage(
                    imageUrl: path!,
                    cacheKey: path!.baseUrl,
                    width: width,
                    height: height,
                    memCacheWidth: cacheWidth,
                    fit: fit,
                    placeholder: (context, url) =>
                        hidePlaceholder ? const SizedBox.shrink() : const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) {
                      if (kDebugMode) {
                        ProductLogger.e('Image load failed: $url', tag: 'ProductImage', error: error);
                      }
                      return errorContainer;
                    },
                  ),
                ),
              ),
            },
          };
        },
      ),
    );
  }
}

class _ErrorContainer extends StatelessWidget {
  const _ErrorContainer({
    this.height = CustomWidgetDimensions.errorImageHeight,
    this.width = CustomWidgetDimensions.errorImageHeight,
    this.errorWidget,
    this.showError = true,
  });

  final double? height;
  final double? width;
  final bool showError;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (!showError) return const SizedBox.shrink();
    if (errorWidget != null) return errorWidget!;
    return Container(
      width: width,
      height: height,
      color: context.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Assets.icons.svg.error.svg(colorFilter: ColorFilter.mode(context.colorScheme.outline, BlendMode.srcIn)),
      ),
    );
  }
}
