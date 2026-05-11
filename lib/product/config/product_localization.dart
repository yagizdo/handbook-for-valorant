import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

final class ProductLocalization extends EasyLocalization {
  ProductLocalization({required super.child, super.key}) : super(supportedLocales: _supportedLocales, path: _path);

  @override
  List<Locale> get supportedLocales => _supportedLocales;

  static final _supportedLocales = Locales.values.map((e) => e.locale).toList();

  static final String _path = Assets.translations.path;
}
