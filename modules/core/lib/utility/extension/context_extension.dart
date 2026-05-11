import 'package:core/widget/base_view/base_view_controller.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  T controller<T extends BaseViewController<dynamic>>() {
    return dependOnInheritedWidgetOfExactType<T>()!;
  }
}
