bool containsOnlyLetters(String string) {
  final regex = RegExp(r'^[a-zA-Z]+$');
  return regex.hasMatch(string);
}

bool containsOnlyDigits(String string) {
  final regex = RegExp(r'^[0-9]+$');
  return regex.hasMatch(string);
}

bool isValidDate(String string) {
  final regex = RegExp(r'^\d{2}.\d{2}.\d{4}$');
  if (!regex.hasMatch(string)) return false;
  final parts = string.split('.');
  if (parts.length != 3) return false;

  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) return false;

  // TODO: finish date validation (for cases like February 29th)

  return true;
}
