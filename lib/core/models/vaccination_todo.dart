class VaccinationTodo {
  final String description;

  VaccinationTodo({
    required this.description,
  });

  factory VaccinationTodo.fromJson(Map<String, dynamic> json) {
    return VaccinationTodo(
      description: json['description'],
    );
  }
}
