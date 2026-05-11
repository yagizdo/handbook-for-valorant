import 'dart:developer' as developer;
import 'dart:io' show stdout;

import 'package:flutter/foundation.dart';

/// Lightweight logger for the application with colored console output.
///
/// Features:
/// - Log levels: debug, info, warning, error
/// - Colored output (ANSI) with graceful fallback
/// - Automatic timestamp and tag support
/// - PII/secrets redaction
/// - Auto-disabled in release builds by default
///
/// Usage:
/// ```dart
/// ProductLogger.i('User logged in', tag: 'AuthService');
/// ProductLogger.e('Failed to fetch', error: e, stackTrace: st);
/// ```
final class ProductLogger {
  ProductLogger._();

  // Configuration
  static LogLevel _minLevel = LogLevel.debug;
  static bool _enabled = kDebugMode;
  static String? _globalTag;
  static bool _useColors = _detectColorSupport();
  static final List<void Function(String)> _logOutputs = [];

  /// Configures the logger settings.
  ///
  /// [minLevel] - Minimum log level to output (default: debug)
  /// [enabled] - Whether logging is enabled (default: true in debug)
  /// [globalTag] - Prefix tag for all logs (e.g., 'MyApp')
  /// [useColors] - Force enable/disable colors (auto-detected by default)
  static void configure({LogLevel? minLevel, bool? enabled, String? globalTag, bool? useColors}) {
    if (minLevel != null) _minLevel = minLevel;
    if (enabled != null) _enabled = enabled;
    if (globalTag != null) _globalTag = globalTag;
    if (useColors != null) _useColors = useColors;
  }

  /// Debug log - for development info, verbose details.
  static void d(String message, {String? tag, Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.debug, message, tag: tag, error: error, stackTrace: stackTrace);

  /// Info log - for general information, state changes.
  static void i(String message, {String? tag, Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.info, message, tag: tag, error: error, stackTrace: stackTrace);

  /// Warning log - for potentially problematic situations.
  static void w(String message, {String? tag, Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.warning, message, tag: tag, error: error, stackTrace: stackTrace);

  /// Error log - for errors and exceptions.
  static void e(String message, {String? tag, Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);

  /// Core logging method.
  static void _log(LogLevel level, String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    if (!_enabled || level.index < _minLevel.index) return;

    final timestamp = _formatTimestamp(DateTime.now());
    final levelStr = level.label;
    final tagStr = _buildTag(tag);
    final colorCode = _useColors ? level.ansiColor : '';
    final resetCode = _useColors ? AnsiColors.reset : '';

    final buffer = StringBuffer()
      ..write(colorCode)
      ..write('[$timestamp] ')
      ..write(levelStr)
      ..write(tagStr.isNotEmpty ? ' [$tagStr]' : '')
      ..write(': ')
      ..write(message)
      ..write(resetCode);

    final formattedLog = buffer.toString();

    developer.log(
      formattedLog,
      name: tagStr.isNotEmpty ? tagStr : level.name.toUpperCase(),
      error: error,
      stackTrace: stackTrace,
      level: level.devToolsLevel,
    );

    for (final output in _logOutputs) {
      output(formattedLog);
    }
  }

  static void addOutput(void Function(String message) output) {
    _logOutputs.add(output);
  }

  static void removeOutput(void Function(String message) output) {
    _logOutputs.remove(output);
  }

  static String _formatTimestamp(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    final ms = time.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }

  static String _buildTag(String? tag) {
    if (_globalTag != null && tag != null) return '$_globalTag/$tag';
    return tag ?? _globalTag ?? '';
  }

  static bool _detectColorSupport() {
    if (kIsWeb) return false;
    try {
      return stdout.supportsAnsiEscapes;
    } on Exception catch (_) {
      return kDebugMode;
    }
  }
}

/// Log levels in order of severity.
enum LogLevel {
  debug(label: '🐛 DEBUG', ansiColor: AnsiColors.gray, devToolsLevel: 500),
  info(label: '💡 INFO', ansiColor: AnsiColors.green, devToolsLevel: 800),
  warning(label: '⚠️ WARN', ansiColor: AnsiColors.yellow, devToolsLevel: 900),
  error(label: '❌ ERROR', ansiColor: AnsiColors.red, devToolsLevel: 1000);

  const LogLevel({required this.label, required this.ansiColor, required this.devToolsLevel});

  final String label;
  final String ansiColor;
  final int devToolsLevel;
}

/// ANSI color codes for terminal output.
abstract final class AnsiColors {
  static const reset = '\x1B[0m';
  static const gray = '\x1B[90m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const red = '\x1B[31m';
}

/// Helper extension for redacting sensitive data before logging.
///
/// Usage:
/// ```dart
/// ProductLogger.i('User email: ${email.redacted}');
/// ProductLogger.d('Token: ${token.redactedPartial()}');
/// ```
extension SensitiveDataRedaction on String {
  /// Fully redacts the string, showing only the type hint.
  String get redacted => '[REDACTED:${length}chars]';

  /// Partially redacts, showing first and last few characters.
  String redactedPartial({int visibleChars = 4}) {
    if (length <= visibleChars * 2) return redacted;
    final start = substring(0, visibleChars);
    final end = substring(length - visibleChars);
    return '$start...$end';
  }
}
