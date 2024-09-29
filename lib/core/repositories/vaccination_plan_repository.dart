import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/enums/vaccination_plan_status.dart';
import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/models/vaccination_plan_details.dart';
import 'package:vma/core/models/vaccination_stage.dart';
import 'package:vma/core/models/vaccination_todo.dart';
import 'package:vma/core/network/api.dart';

class VaccinationPlanRepository {
  Future<List<VaccinationPlan>> getAllVaccinationPlans() async {
    final result = await ApiCaller.instance.request(
      path: '/api/Herds/31c334fc-308a-40a9-a058-21bc4c4a3da0/vaccination-plans',
      method: ApiMethod.get,
    );

    List<VaccinationPlan> plans = [];

    result.either((success) {
      final data = success.data as List<dynamic>;
      plans = data
          .fromJsonToList<VaccinationPlan>((e) => VaccinationPlan.fromJson(e));
    }, (error) {
      // handle error
    });

    return Future.value(plans);
  }

  Future<VaccinationPlanDetails> getPlanById(String id) {
    final plan = VaccinationPlanDetails(
      id: '1',
      title: 'Vaccination Plan 1',
      description: 'Description 1',
      startDate: DateTime(2024, 1, 1),
      expectedEndDate: DateTime(2024, 12, 1),
      status: VaccinationPlanStatus.onGoing,
      note: 'Note 1',
      pigCount: 10,
      vaccinationStages: [
        VaccinationStage(
          vaccinationPlanId: id,
          title: 'Vaccination Stage 1',
          applyStageTime: DateTime.now(),
          isDone: false,
          timeSpan: 'Time Span 1',
          vaccinationTodos: [
            VaccinationTodo(
              id: 'Vaccination Todo 1',
              description: 'Description 1',
              vaccinationStageId: 'foo',
            ),
            VaccinationTodo(
              id: 'Vaccination Todo 2',
              description: 'Description 2',
              vaccinationStageId: 'foo',
            ),
            VaccinationTodo(
              id: 'Vaccination Todo 3',
              description: 'Description 3',
              vaccinationStageId: 'foo',
            ),
          ],
        ),
        VaccinationStage(
          vaccinationPlanId: id,
          title: 'Vaccination Stage 1',
          applyStageTime: DateTime.now(),
          isDone: false,
          timeSpan: 'Time Span 1',
          vaccinationTodos: [
            VaccinationTodo(
              id: 'Vaccination Todo 1',
              description: 'Description 1',
              vaccinationStageId: 'foo',
            ),
            VaccinationTodo(
              id: 'Vaccination Todo 2',
              description: 'Description 2',
              vaccinationStageId: 'foo',
            ),
            VaccinationTodo(
              id: 'Vaccination Todo 3',
              description: 'Description 3',
              vaccinationStageId: 'foo',
            ),
          ],
        ),
      ],
    );

    return Future.value(plan);
  }
}
