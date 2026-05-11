import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button_overlay.dart';
import 'package:handbook_for_valorant/product/widgets/product_error.dart';
import 'package:handbook_for_valorant/product/widgets/product_scaffold.dart';

/// A full-screen scaffold showing an error message with a back button overlay.
///
/// Used on detail views when the requested item is not found.
class ProductNotFoundView extends StatelessWidget {
  const ProductNotFoundView({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return ProductScaffold(
      body: Stack(
        children: [
          ProductError(message: message),
          const ProductBackButtonOverlay(),
        ],
      ),
    );
  }
}
