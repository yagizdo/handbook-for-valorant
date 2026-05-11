import 'package:flutter/material.dart';

/// Extension on [BuildContext] for easy theme access.
///
/// Usage:
/// ```dart
/// Access color scheme:
/// final primary = context.colorScheme.primary;
///
/// Access text theme:
/// final bodyStyle = context.textTheme.bodyMedium;
///
/// Check brightness:
/// if (context.isDarkMode) { ... }
/// ```
extension ThemeExtension on BuildContext {
  /// Access the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Access the current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Access the current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Returns true if current theme is dark mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Returns true if current theme is light mode.
  bool get isLightMode => theme.brightness == Brightness.light;
}
