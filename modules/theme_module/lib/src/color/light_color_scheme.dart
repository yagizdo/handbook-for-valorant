import 'package:flutter/material.dart';

import 'package:theme_module/src/color/app_color_scheme.dart';

/// Light theme color scheme implementation.
///
/// Provides a light mode color palette following Material 3 guidelines.
/// Extend or modify colors here to customize the light theme appearance.
final class LightColorScheme extends AppColorScheme {
  const LightColorScheme();

  @override
  Brightness get brightness => Brightness.light;

  @override
  ColorScheme get colorScheme => const ColorScheme.light(
    primary: Color(0xFFFF4655),
    secondary: Color(0xFFBD3944),
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFFF5F0EB),
    onSurface: Color(0xFF101823),
    outline: Color(0xFF787878),
    surfaceContainerHighest: Color(0xFFE5E0D9),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
