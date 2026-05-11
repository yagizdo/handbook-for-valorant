import 'package:flutter/material.dart';

import 'package:theme_module/src/color/app_color_scheme.dart';

/// Dark theme color scheme implementation.
///
/// Provides a dark mode color palette following Material 3 guidelines.
/// Extend or modify colors here to customize the dark theme appearance.
final class DarkColorScheme extends AppColorScheme {
  const DarkColorScheme();

  @override
  Brightness get brightness => Brightness.dark;

  @override
  ColorScheme get colorScheme => const ColorScheme.dark(
    primary: Color(0xFFFF4655),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFBD3944),
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFF101823),
    onSurface: Color(0xFFE5E0D9),
    outline: Color(0xFF787878),
    surfaceContainerHighest: Color(0xFF1A2636),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
