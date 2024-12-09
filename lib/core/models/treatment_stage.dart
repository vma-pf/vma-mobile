import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/treatment_todo.dart';

class TreatmentStage {
  final String id;
  final String treatmentPlanId;
  final String title;
  final String timeSpan;
  final String note;
  final bool isDone;
  final DateTime applyStageTime;
  final List<TreatmentTodo> treatmentTodos;

  TreatmentStage({
    required this.id,
    required this.treatmentPlanId,
    required this.title,
    required this.timeSpan,
    required this.note,
    required this.isDone,
    required this.applyStageTime,
    required this.treatmentTodos,
  });

  factory TreatmentStage.fromJson(Map<String, dynamic> json) {
    return TreatmentStage(
      id: json['id'],
      treatmentPlanId: json['treatmentPlanId'],
      title: json['title'],
      timeSpan: json['timeSpan'],
      note: json['note'],
      isDone: json['isDone'],
      applyStageTime: DateTime.parse(json['applyStageTime']),
      treatmentTodos: (json['treatmentToDos'] as List<dynamic>)
          .fromJsonToList(TreatmentTodo.fromJson),
    );
  }
}
