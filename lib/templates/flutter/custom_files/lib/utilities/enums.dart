T? findEnumSafely<T>(List<T> values, String? name) {
  if (name == null) return null;
  try {
    return values.firstWhere((type) => type.toString().split('.').last == name);
  } catch (e) {
    return null;
  }
}
