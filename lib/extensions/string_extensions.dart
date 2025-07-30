extension StringExtensions on String {
  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(this);

  String get capitalized =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  bool get isNullOrEmpty => trim().isEmpty;

  String get trimmed => trim();
}
