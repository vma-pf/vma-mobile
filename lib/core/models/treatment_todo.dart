class TreatmentTodo {
  final String id;
  final String description;
  final String treatmentStageId;

  TreatmentTodo({
    required this.id,
    required this.description,
    required this.treatmentStageId,
  });

  factory TreatmentTodo.fromJson(Map<String, dynamic> json) {
    return TreatmentTodo(
      id: json['id'],
      description: json['description'],
      treatmentStageId: json['treatmentStageId'],
    );
  }
}
