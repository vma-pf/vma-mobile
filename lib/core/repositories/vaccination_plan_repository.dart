import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/models/vaccination_plan_details.dart';
import 'package:vma/core/network/api.dart';

class VaccinationPlanRepository {
  Future<List<VaccinationPlan>> getVaccinationPlansByHerd(String herdId) async {
    final result = await ApiCaller.instance.request(
      path: '/api/Herds/$herdId/vaccination-plans',
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

  Future<VaccinationPlanDetails> getPlanById(String id) async {
    final result = await ApiCaller.instance.request(
      path: '/get-vaccination-plan/$id',
      method: ApiMethod.get,
    );

    VaccinationPlanDetails? plan;

    result.either((success) {
      final data = success.data as Map<String, dynamic>;
      plan = VaccinationPlanDetails.fromJson(data);
    }, (error) {
      // TODO: handle error
    });

    return Future.value(plan);
  }
}
