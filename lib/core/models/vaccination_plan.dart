import 'package:vma/core/models/enums/vaccination_plan_status.dart';

class VaccinationPlan {
  final String id;
  final String title;
  final String description;
  final String note;
  final DateTime startDate;
  final DateTime endDate;
  final VaccinationPlanStatus status;
  final int pigCount;

  VaccinationPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.note,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.pigCount,
  });

  factory VaccinationPlan.fromJson(Map<String, dynamic> json) {
    return VaccinationPlan(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      note: json['note'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: VaccinationPlanStatus.values
          .firstWhere((e) => e.toString() == json['status']),
      pigCount: json['pigCount'],
    );
  }
}
