import 'package:flutter/material.dart';

import 'package:theme_module/src/color/app_color_scheme.dart';
import 'package:theme_module/src/color/dark_color_scheme.dart';
import 'package:theme_module/src/color/light_color_scheme.dart';
import 'package:theme_module/src/text/app_text_theme.dart';
import 'package:theme_module/src/theme_type.dart';

/// Main theme configuration class for the app.
///
/// Provides [ThemeData] for different theme types (light, dark).
/// Designed to be extensible for additional color schemes.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///   themeMode: ThemeMode.system,
/// )
/// ```
final class AppTheme {
  const AppTheme._();

  // Color scheme instances
  static const AppColorScheme _lightColorScheme = LightColorScheme();
  static const AppColorScheme _darkColorScheme = DarkColorScheme();

  /// Light theme data.
  static ThemeData get light => _buildTheme(_lightColorScheme);

  /// Dark theme data.
  static ThemeData get dark => _buildTheme(_darkColorScheme);

  /// Gets [ThemeData] for a specific [ThemeType].
  static ThemeData getThemeData(ThemeType type) {
    switch (type) {
      case ThemeType.light:
        return light;
      case ThemeType.dark:
        return dark;
    }
  }

  /// Gets [AppColorScheme] for a specific [ThemeType].
  static AppColorScheme getColorScheme(ThemeType type) {
    switch (type) {
      case ThemeType.light:
        return _lightColorScheme;
      case ThemeType.dark:
        return _darkColorScheme;
    }
  }

  /// Converts [ThemeType] to Flutter's [ThemeMode].
  static ThemeMode toThemeMode(ThemeType type) {
    switch (type) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
    }
  }

  /// Builds a complete [ThemeData] from an [AppColorScheme].
  static ThemeData _buildTheme(AppColorScheme colorScheme) {
    final scheme = colorScheme.colorScheme;
    final textTheme = AppTextTheme.textTheme(color: scheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: colorScheme.brightness,
      fontFamily: AppTextTheme.fontFamily,
      textTheme: textTheme,
      primaryTextTheme: textTheme,

      // Scaffold
      scaffoldBackgroundColor: scheme.surface,

      // AppBar
      appBarTheme: AppBarTheme(backgroundColor: scheme.surface, foregroundColor: scheme.onSurface, elevation: 0),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Input Decoration (TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: scheme.error, width: 2),
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
        hintStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.6)),
        errorStyle: textTheme.bodySmall?.copyWith(color: scheme.error),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Icon
      iconTheme: IconThemeData(color: scheme.onSurface, size: 24),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.surface.withValues(alpha: 0);
        }),
        checkColor: WidgetStateProperty.all(scheme.onPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary.withValues(alpha: 0.5);
          }
          return scheme.surfaceContainerHighest;
        }),
      ),

      // Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),
    );
  }
}
