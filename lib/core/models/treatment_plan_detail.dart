import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/treatment_stage.dart';

class TreatmentPlanDetail {
  final String id;
  final String? treatmentGuideId;
  final String title;
  final String description;
  final DateTime expectedTimePeriod;
  final DateTime actualTimePeriod;
  final String note;
  final String status;
  final List<TreatmentStage> treatmentStages;

  TreatmentPlanDetail({
    required this.id,
    required this.treatmentGuideId,
    required this.title,
    required this.description,
    required this.expectedTimePeriod,
    required this.actualTimePeriod,
    required this.note,
    required this.status,
    required this.treatmentStages,
  });

  factory TreatmentPlanDetail.fromJson(Map<String, dynamic> json) {
    return TreatmentPlanDetail(
      id: json['id'],
      treatmentGuideId: json['treatmentGuideId'],
      title: json['title'],
      description: json['description'],
      expectedTimePeriod: DateTime.parse(json['expectedTimePeriod']),
      actualTimePeriod: DateTime.parse(json['actualTimePeriod']),
      note: json['note'],
      status: json['status'],
      treatmentStages: (json['treatmentStages'] as List<dynamic>)
          .fromJsonToList(TreatmentStage.fromJson),
    );
  }
}
