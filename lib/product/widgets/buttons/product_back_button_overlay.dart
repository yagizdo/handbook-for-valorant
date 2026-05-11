import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button.dart';

/// A [Positioned] wrapper that places a [ProductBackButton] at the top-left
/// corner of a [Stack], respecting the device's safe area insets.
class ProductBackButtonOverlay extends StatelessWidget {
  const ProductBackButtonOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + Dimensions.md,
      left: Dimensions.lg,
      child: const ProductBackButton(),
    );
  }
}
