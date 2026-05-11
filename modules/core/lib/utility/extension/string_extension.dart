import 'package:core/constants/regex_constants.dart';

extension StringExtension on String {
  bool get isURL => RegexConstants.url.hasMatch(this);
}

extension FileTypeExt on String {
  /// Url without query parameters.
  String get baseUrl => split('?').firstOrNull ?? this;
}
