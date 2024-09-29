extension JsonToListExtenion on List<dynamic> {
  List<T> fromJsonToList<T>(T Function(Map<String, dynamic>) fromJson) {
    final result = map((e) => fromJson(e as Map<String, dynamic>)).toList();
    return result;
  }
}
