class EnumHelper {
  static T? jsonToEnum<T>(List<T> values, dynamic rawValue) {
    if (rawValue == null) {
      return null;
    }
    if (rawValue is String) {
      return values.firstWhere((e) => e.toString() == rawValue.toString());
    }
    if (rawValue is int) {
      return values[rawValue];
    }

    throw Exception('Invalid enum value');
  }
}
