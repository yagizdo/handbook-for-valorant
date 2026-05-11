import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:theme_module/src/theme_type.dart';

part 'theme_state.freezed.dart';

/// State class for theme management using Freezed.
///
/// Holds the current [ThemeType] and provides immutable state updates.
@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({@Default(ThemeType.dark) ThemeType themeType, @Default(false) bool isInitialized}) =
      _ThemeState;

  const ThemeState._();

  /// Returns true if current theme is dark mode.
  bool get isDarkMode => themeType == ThemeType.dark;

  /// Returns true if current theme is light mode.
  bool get isLightMode => themeType == ThemeType.light;
}
