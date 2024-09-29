class PigVaccinationStage {
  final String id;
  final bool isDone;
  final DateTime applyStageTime;
  final String vaccinationStageId;

  PigVaccinationStage({
    required this.id,
    required this.isDone,
    required this.applyStageTime,
    required this.vaccinationStageId,
  });

  factory PigVaccinationStage.fromJson(Map<String, dynamic> json) {
    return PigVaccinationStage(
      id: json['id'],
      isDone: json['isDone'],
      // applyStageTime: DateTime.parse(json['applyStageTime']),
      applyStageTime: DateTime.now(),
      vaccinationStageId: json['vaccinationStageId'],
    );
  }
}
