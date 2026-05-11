import 'package:flutter/material.dart';

class ProductScaffold extends StatelessWidget {
  const ProductScaffold({
    required this.body,
    super.key,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.actions,
    this.showBackButton = true,
  });
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text(title!), automaticallyImplyLeading: showBackButton, actions: actions)
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
