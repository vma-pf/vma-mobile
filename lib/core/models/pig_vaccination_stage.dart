class PigVaccinationStage {
  final bool isDone;
  final DateTime applyStageTime;
  final String vaccinationStageId;

  PigVaccinationStage({
    required this.isDone,
    required this.applyStageTime,
    required this.vaccinationStageId,
  });

  factory PigVaccinationStage.fromJson(Map<String, dynamic> json) {
    return PigVaccinationStage(
      isDone: json['isDone'],
      applyStageTime: DateTime.parse(json['applyStageTime']),
      vaccinationStageId: json['vaccinationStageId'],
    );
  }
}
