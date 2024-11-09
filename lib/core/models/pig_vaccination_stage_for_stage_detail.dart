import 'package:vma/core/models/pig_for_pig_vaccination.dart';

class PigVaccinationStageForStageDetail {
  final String vaccinationStageId;
  final String vaccinationStageTitle;
  final bool isDone;
  final PigForPigVaccination pig;

  PigVaccinationStageForStageDetail({
    required this.vaccinationStageId,
    required this.vaccinationStageTitle,
    required this.isDone,
    required this.pig,
  });

  factory PigVaccinationStageForStageDetail.fromJson(
    Map<String, dynamic> json,
  ) {
    return PigVaccinationStageForStageDetail(
      vaccinationStageId: json['vaccinationStageId'],
      vaccinationStageTitle: json['vaccinationStageTitle'],
      isDone: json['isDone'],
      pig: PigForPigVaccination.fromJson(json['pig']),
    );
  }
}
