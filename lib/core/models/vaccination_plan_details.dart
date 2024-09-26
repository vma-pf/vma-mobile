import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/models/vaccination_stage.dart';

class VaccinationPlanDetails extends VaccinationPlan {
  final List<VaccinationStage> vaccinationStages;

  VaccinationPlanDetails({
    required super.title,
    required super.description,
    required super.note,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.pigCount,
    required this.vaccinationStages,
  });

  factory VaccinationPlanDetails.fromJson(Map<String, dynamic> json) {
    return VaccinationPlanDetails(
      title: json['title'],
      description: json['description'],
      note: json['note'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      pigCount: json['pigCount'],
      vaccinationStages: json['vaccinationStages'],
    );
  }
}
