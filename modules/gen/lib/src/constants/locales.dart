import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum Locales {
  /// English
  en(Locale('en', 'US')),

  /// Turkish
  tr(Locale('tr', 'TR'));

  const Locales(this.locale);

  /// Locale value
  final Locale locale;

  void init() {
    Intl.defaultLocale = name.tr();
  }

  Future<void> updateLanguage(BuildContext context) async {
    await context.setLocale(locale);
    Intl.defaultLocale = name.tr();
  }

  String get nativeName => switch (this) {
    Locales.en => 'English',
    Locales.tr => 'Türkçe',
  };

  String get apiLanguageCode => '${locale.languageCode}-${locale.countryCode}';

  static Locales current(BuildContext context) =>
      Locales.values.firstWhere((element) => element.locale == context.locale, orElse: () => Locales.en);

  static Locales fromString(String value) =>
      Locales.values.firstWhere((element) => element.locale.languageCode == value, orElse: () => Locales.en);
}
