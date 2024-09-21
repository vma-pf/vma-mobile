import 'package:vma/core/models/enums/pig_status.dart';
import 'package:vma/core/models/monitoring_development_log.dart';
import 'package:vma/core/models/pig_vaccination_stage.dart';

class PigDetail {
  final String id;
  final PigStatus status;
  final String herdId;
  final String code;
  final String gender;
  final String breed;
  final List<MonitoringDevelopmentLog> monitoringDevelopmentLogs;
  final List<PigVaccinationStage> pigVaccinationStages;

  PigDetail({
    required this.id,
    required this.status,
    required this.herdId,
    required this.code,
    required this.gender,
    required this.breed,
    required this.monitoringDevelopmentLogs,
    required this.pigVaccinationStages,
  });

  factory PigDetail.fromJson(Map<String, dynamic> json) {
    return PigDetail(
      id: json['id'],
      status: json['status'],
      herdId: json['herdId'],
      code: json['code'],
      gender: json['gender'],
      breed: json['breed'],
      monitoringDevelopmentLogs: json['monitoringDevelopmentLogs'],
      pigVaccinationStages: json['pigVaccinationStages'],
    );
  }
}
