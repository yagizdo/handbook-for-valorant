import 'package:flutter/material.dart';

abstract class BaseViewController<T> extends InheritedWidget {
  const BaseViewController({required super.child, required this.context, super.key});
  final BuildContext context;

  @mustCallSuper
  void onInit();

  @mustCallSuper
  void onDispose();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
