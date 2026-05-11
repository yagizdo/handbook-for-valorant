final class RegexConstants {
  RegexConstants._();

  static final empty = RegExp('');

  static final url = RegExp(
    r'^(?:http|https):\/\/(?:(?:[A-Z0-9][A-Z0-9_-]*\.)+[A-Z]{2,})(?::\d{1,5})?(?:\/[^\s]*)?$',
    caseSensitive: false,
  );
}
