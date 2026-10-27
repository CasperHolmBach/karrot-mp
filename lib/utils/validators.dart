// Empty or whitespace-only titles are invalid.
String? validateTitle(String? v) {
  if (v == null || v.trim().isEmpty) return 'Please enter a title';
  return null;
}

// A non-negative integer. Empty is allowed and means 0 (Free).
String? validatePrice(String? v) {
  if (v == null || v.trim().isEmpty) return null;
  final price = int.tryParse(v.trim());
  if (price == null || price < 0) return 'Please enter a valid price';
  return null;
}
