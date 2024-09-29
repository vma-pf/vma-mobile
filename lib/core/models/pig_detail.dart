import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/enums/pig_status.dart';
import 'package:vma/core/models/monitoring_development_log.dart';
import 'package:vma/core/models/pig_vaccination_stage.dart';
import 'package:vma/core/utils/enum_helper.dart';

class PigDetail {
  final String id;
  final PigStatus status;
  final String herdId;
  final String code;
  final String currentCageCode;
  final String gender;
  final String breed;
  final List<MonitoringDevelopmentLog> monitoringDevelopmentLogs;
  final List<PigVaccinationStage> pigVaccinationStages;

  PigDetail({
    required this.id,
    required this.status,
    required this.herdId,
    required this.code,
    required this.currentCageCode,
    required this.gender,
    required this.breed,
    required this.monitoringDevelopmentLogs,
    required this.pigVaccinationStages,
  });

  factory PigDetail.fromJson(Map<String, dynamic> json) {
    return PigDetail(
      id: json['id'],
      // status: json['status'],
      status: EnumHelper.jsonToEnum(PigStatus.values, json['status']) ??
          PigStatus.alive,
      herdId: json['herdId'],
      code: json['code'],
      currentCageCode: json['currentCageCode'],
      gender: json['gender'],
      breed: json['breed'],
      monitoringDevelopmentLogs:
          (json['monitoringDevelopmentLogs'] as List<dynamic>)
              .fromJsonToList(MonitoringDevelopmentLog.fromJson),
      pigVaccinationStages: (json['pigVaccinationStages'] as List<dynamic>)
          .fromJsonToList(PigVaccinationStage.fromJson),
    );
  }
}
