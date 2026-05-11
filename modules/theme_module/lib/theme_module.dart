/// A modular theme system for Flutter apps.
///
/// Provides light/dark mode support with extensible color schemes.
///
/// Usage:
/// ```dart
/// import 'package:theme_module/theme_module.dart';
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
///   themeMode: ThemeMode.system,
/// )
/// ```

library;

// Core
export 'src/app_theme.dart';
// Color schemes
export 'src/color/app_color_scheme.dart';
export 'src/color/dark_color_scheme.dart';
export 'src/color/light_color_scheme.dart';
// State management
export 'src/cubit/theme_cubit.dart';
export 'src/cubit/theme_state.dart';
// Extensions
export 'src/extension/theme_extension.dart';
// Text theme
export 'src/text/app_text_theme.dart';
export 'src/theme_type.dart';
