enum SignatureFieldType {
  signature,  // Full signature
  name,       // Signer's full name
  date,       // Auto-filled date
  text,       // Custom text
}

String _formattedTodayDate() {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}

extension SignatureFieldTypeExtension on SignatureFieldType {
  String get displayName {
    switch (this) {
      case SignatureFieldType.signature:
        return 'Signature';
      case SignatureFieldType.name:
        return 'Name';
      case SignatureFieldType.date:
        return _formattedTodayDate(); // formatted current date
      case SignatureFieldType.text:
        return 'Text';
    }
  }

  String get description {
    switch (this) {
      case SignatureFieldType.signature:
        return 'A full signature field for signing';
      case SignatureFieldType.name:
        return 'Auto-filled signer name';
      case SignatureFieldType.date:
        return 'Auto-filled date of signing';
      case SignatureFieldType.text:
        return 'Custom text input field';
    }
  }

  String get typeKey {
    return toString().split('.').last;
  }
}
