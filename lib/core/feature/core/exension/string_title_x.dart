extension StringTitleX on String {
  /// Capitalizes first letter, lowercases the rest.
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Capitalizes first letter of each word, lowercases the rest.
  String get toTitleCase => replaceAll(
        RegExp(' +'),
        ' ',
      ).split(' ').map((str) => str.toCapitalized).join(' ');
}

/// Converts string to null if it's empty.
///
/// Reduces boilerplate with `isNotEmpty` checks.
extension MaybeStringX on String? {
  String? get notEmpty => (this?.isNotEmpty ?? true) ? this : null;
}
