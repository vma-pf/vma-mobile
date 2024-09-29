import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/models/vaccination_stage.dart';

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
      status: json['status'],
      pigCount: json['pigCount'],
      vaccinationStages: json['vaccinationStages'],
    );
  }
}
