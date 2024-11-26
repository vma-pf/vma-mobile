import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/medicine.dart';
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

  Future<List<Medicine>> getMedicinesByStageId(String stageId) async {
    final result = await ApiCaller.instance.request(
      path: '/vaccination-stages/$stageId/medicines',
      method: ApiMethod.get,
    );

    List<Medicine> medicines = [];

    result.either((success) {
      final data = success.data as Map<String, dynamic>;
      final medData = data['medicine'] as List<dynamic>;
      medicines = medData.fromJsonToList(Medicine.fromJson);
    }, (error) {
      // TODO: handle error
    });

    return Future.value(medicines);
  }

  Future<void> updateVaccinationStage(
    String stageId,
    List<String> pigIds,
  ) async {
    final result = await ApiCaller.instance.request(
      path: '/vaccination-stages/$stageId/medicines',
      method: ApiMethod.get,
      data: pigIds,
    );

    result.either((success) {
      // TODO: handle successful response
    }, (error) {
      // TODO: handle error
    });
  }

  Future<void> requestMedicines(
    List<String> medicineIds,
  ) async {
    final result = await ApiCaller.instance.request(
      path: '/api/MedicineRequests/change-status-requested',
      method: ApiMethod.put,
      data: medicineIds,
      headers: {'Content-Type': 'application/json-patch+json'},
    );

    result.either((success) {
      // TODO: handle successful response
    }, (error) {
      // TODO: handle error
    });
  }
}
