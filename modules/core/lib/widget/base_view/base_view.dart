import 'package:core/widget/base_view/base_view_controller.dart';
import 'package:flutter/material.dart';

class BaseView<T> extends StatefulWidget {
  const BaseView({required this.controller, super.key});

  final BaseViewController<T> controller;

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T> extends State<BaseView<T>> {
  late final controller = widget.controller;
  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  @override
  void dispose() {
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller;
  }
}
