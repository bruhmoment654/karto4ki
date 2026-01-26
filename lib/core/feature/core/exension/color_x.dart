import 'dart:ui';

extension ColorX on Color {
  String get colorHtmlCode =>
      // ignore: deprecated_member_use
      '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
}
