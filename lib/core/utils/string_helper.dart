class StringHelper {
  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  static String resolveNullableString(String? value, String alternativeValue) {
    if (value == null || value.isEmpty) {
      return alternativeValue;
    }

    return value;
  }
}
