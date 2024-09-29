import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/vaccination_todo.dart';

class VaccinationStage {
  final String vaccinationPlanId;
  final String title;
  final String timeSpan;
  final DateTime applyStageTime;
  final bool isDone;
  final List<VaccinationTodo> vaccinationTodos;

  VaccinationStage({
    required this.vaccinationPlanId,
    required this.title,
    required this.timeSpan,
    required this.applyStageTime,
    required this.isDone,
    required this.vaccinationTodos,
  });

  factory VaccinationStage.fromJson(Map<String, dynamic> json) {
    return VaccinationStage(
      vaccinationPlanId: json['vaccinationPlanId'],
      title: json['title'],
      timeSpan: json['timeSpan'],
      applyStageTime: DateTime.parse(json['applyStageTime']),
      isDone: json['isDone'],
      vaccinationTodos: ((json['vaccinationTodos'] ?? []) as List<dynamic>)
          .fromJsonToList(VaccinationTodo.fromJson),
    );
  }
}
