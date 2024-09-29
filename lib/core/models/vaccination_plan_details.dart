import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/enums/vaccination_plan_status.dart';
import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/models/vaccination_stage.dart';
import 'package:vma/core/utils/enum_helper.dart';

class VaccinationPlanDetails extends VaccinationPlan {
  final List<VaccinationStage> vaccinationStages;

  VaccinationPlanDetails({
    required super.id,
    required super.title,
    required super.description,
    required super.note,
    required super.startDate,
    required super.expectedEndDate,
    required super.status,
    required super.pigCount,
    required this.vaccinationStages,
  });

  factory VaccinationPlanDetails.fromJson(Map<String, dynamic> json) {
    return VaccinationPlanDetails(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      note: json['note'],
      startDate: DateTime.parse(json['startDate']),
      expectedEndDate: DateTime.parse(json['expectedEndDate']),
      status:
          EnumHelper.jsonToEnum(VaccinationPlanStatus.values, json['status']) ??
              VaccinationPlanStatus.unknown,
      // pigCount: json['pigCount'],
      pigCount: 0,
      vaccinationStages: (json['vaccinationStages'] as List<dynamic>)
          .fromJsonToList(VaccinationStage.fromJson),
    );
  }
}
