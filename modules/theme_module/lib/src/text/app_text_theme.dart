import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

/// Centralized text theme configuration for the app.
///
/// Provides consistent typography following Material 3 guidelines.
/// Access via `Theme.of(context).textTheme.bodyMedium` etc.
///
/// Custom styles can be added as static getters if needed.
final class AppTextTheme {
  const AppTextTheme._();

  /// Package prefix required for fonts declared in a Flutter package dependency.
  static const String _genPackagePrefix = 'packages/gen/';

  /// Valorant font family — used for headline/display styles (brand text).
  static const String valorantFontFamily = _genPackagePrefix + FontFamily.valorant;

  /// Inter font family — used for title/body/label styles (readable content).
  static const String interFontFamily = _genPackagePrefix + FontFamily.inter;

  /// Default font family used across the app (Inter for readability).
  static const String fontFamily = interFontFamily;

  /// Creates the app's TextTheme with the specified [color].
  ///
  /// Font split:
  /// - display* + headline* → Valorant (brand font for titles and names)
  /// - title* + body* + label* → Inter (readable font for content and UI)
  static TextTheme textTheme({Color? color}) {
    return TextTheme(
      // Display styles — Valorant (brand)
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        fontFamily: valorantFontFamily,
        color: color,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: valorantFontFamily,
        color: color,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: valorantFontFamily,
        color: color,
      ),

      // Headline styles — Valorant (brand)
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: valorantFontFamily,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: valorantFontFamily,
        color: color,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: valorantFontFamily,
        color: color,
      ),

      // Title styles — Inter (readable)
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
        fontFamily: interFontFamily,
        color: color,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        fontFamily: interFontFamily,
        color: color,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        fontFamily: interFontFamily,
        color: color,
      ),

      // Body styles — Inter (readable)
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: interFontFamily,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        fontFamily: interFontFamily,
        color: color,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        fontFamily: interFontFamily,
        color: color,
      ),

      // Label styles — Inter (readable)
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        fontFamily: interFontFamily,
        color: color,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        fontFamily: interFontFamily,
        color: color,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        fontFamily: interFontFamily,
        color: color,
      ),
    );
  }
}
