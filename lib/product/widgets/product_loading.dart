import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color ?? context.colorScheme.primary));
  }
}
