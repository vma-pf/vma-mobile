class VaccinationTodo {
  final String id;
  final String vaccinationStageId;
  final String description;

  VaccinationTodo({
    required this.id,
    required this.vaccinationStageId,
    required this.description,
  });

  factory VaccinationTodo.fromJson(Map<String, dynamic> json) {
    return VaccinationTodo(
      id: json['id'],
      vaccinationStageId: json['vaccinationStageId'],
      description: json['description'],
    );
  }
}
