import 'package:flutter/material.dart';

/// Abstract base class for app color schemes.
///
/// Implement this class to create custom color schemes (light, dark, blue, etc.).
/// Each implementation must provide a [ColorScheme] for Material 3 theming.
///
/// Usage:
/// ```dart
/// class CustomColorScheme extends AppColorScheme {
///   @override
///   ColorScheme get colorScheme => ColorScheme(...);
/// }
/// ```
abstract class AppColorScheme {
  const AppColorScheme();

  /// The Material 3 ColorScheme for this theme.
  ColorScheme get colorScheme;

  /// Brightness of this color scheme (light or dark).
  Brightness get brightness;

  /// Primary brand color.
  Color get primary => colorScheme.primary;

  /// Secondary brand color.
  Color get secondary => colorScheme.secondary;

  /// Background color for screens.
  Color get background => colorScheme.surface;

  /// Surface color for cards, sheets, menus.
  Color get surface => colorScheme.surface;

  /// Error color for validation, destructive actions.
  Color get error => colorScheme.error;

  /// Color for text/icons on primary color.
  Color get onPrimary => colorScheme.onPrimary;

  /// Color for text/icons on secondary color.
  Color get onSecondary => colorScheme.onSecondary;

  /// Color for text/icons on background.
  Color get onBackground => colorScheme.onSurface;

  /// Color for text/icons on surface.
  Color get onSurface => colorScheme.onSurface;

  /// Color for text/icons on error.
  Color get onError => colorScheme.onError;

  /// Outline color for borders, dividers.
  Color get outline => colorScheme.outline;

  /// Surface variant for subtle backgrounds.
  Color get surfaceVariant => colorScheme.surfaceContainerHighest;
}
