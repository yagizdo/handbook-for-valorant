import 'dart:ui' show Brightness;

import 'package:core/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_module/src/cubit/theme_state.dart';
import 'package:theme_module/src/theme_type.dart';

/// Cubit for managing app theme state.
///
/// Handles theme switching between light and dark modes.
/// Persists theme preference to local cache via [BaseRepository].
///
/// Usage:
/// ```dart
/// BlocProvider<ThemeCubit>(
///   create: (_) => ThemeCubit(themeRepository: repo)..init(),
///   child: App(),
/// )
///
/// Toggle theme:
/// context.read<ThemeCubit>().toggleTheme();
///
/// Set specific theme:
/// context.read<ThemeCubit>().setTheme(ThemeType.dark);
/// ```
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({this.themeRepository}) : super(const ThemeState());

  final BaseRepository<ThemeModel>? themeRepository;

  static const String _tag = 'ThemeCubit';

  /// Initializes the theme cubit.
  ///
  /// Loads saved theme preference from cache if available.
  void init() {
    _log('Initializing theme system');

    final cachedTheme = _loadCachedTheme();
    final themeType = cachedTheme ?? ThemeType.dark;

    _log('Using ${themeType.name} mode');
    emit(state.copyWith(themeType: themeType, isInitialized: true));
    _log('Theme system ready');
  }

  /// Toggles between light and dark theme.
  void toggleTheme() {
    final currentTheme = state.themeType;
    final newTheme = currentTheme == ThemeType.light ? ThemeType.dark : ThemeType.light;
    _log('Toggling theme: ${currentTheme.name} → ${newTheme.name}');
    _updateTheme(newTheme);
  }

  /// Sets a specific theme type.
  void setTheme(ThemeType type) {
    if (state.themeType == type) {
      _log('Theme already set to ${type.name}, skipping');
      return;
    }
    _log('Setting theme: ${state.themeType.name} → ${type.name}');
    _updateTheme(type);
  }

  /// Sets theme based on system brightness.
  void setThemeFromBrightness(Brightness brightness) {
    final type = brightness == Brightness.dark ? ThemeType.dark : ThemeType.light;
    _log('Detected system brightness: ${brightness.name}');
    setTheme(type);
  }

  void _updateTheme(ThemeType type) {
    emit(state.copyWith(themeType: type));
    _persistTheme(type);
    _log('Theme changed to ${type.name} mode');
  }

  ThemeType? _loadCachedTheme() {
    try {
      final model = themeRepository?.getAll().firstOrNull;
      if (model?.theme == null) return null;
      return ThemeType.values.where((t) => t.name == model!.theme).firstOrNull;
    } on Exception catch (e) {
      _log('Failed to load cached theme: $e');
      return null;
    }
  }

  void _persistTheme(ThemeType type) {
    try {
      // Clear previous entry, then insert fresh — ObjectBox manages IDs
      themeRepository?.deleteAll();
      themeRepository?.save(ThemeModel()..theme = type.name);
    } on Exception catch (e) {
      _log('Failed to persist theme: $e');
    }
  }

  void _log(String message) {
    ProductLogger.i(message, tag: _tag);
  }
}
