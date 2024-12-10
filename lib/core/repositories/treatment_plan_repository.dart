import 'package:vma/core/models/treatment_plan.dart';
import 'package:vma/core/models/treatment_plan_detail.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class TreatmentPlanRepository {
  Future<List<TreatmentPlan>> getAllTreatmentPlans() async {
    final int pageSize = 999;
    final int pageIndex = 1;
    final query = {
      'pageSize': pageSize,
      'pageIndex': pageIndex,
    };
    final result = await ApiCaller.instance.request(
      path: '/api/TreatmentPlans',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<TreatmentPlan> response = PaginatedResponse(
      pageIndex: pageIndex,
      pageSize: pageSize,
      totalRecords: 0,
      totalPages: 0,
      data: <TreatmentPlan>[],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => TreatmentPlan.fromJson(e),
      );
    }, (error) {
      // handle error
    });

    return Future.value(response.data);
  }

  // FIXME: call correct api
  Future<TreatmentPlanDetail> getPlanById(String id) async {
    final result = await ApiCaller.instance.request(
      path: '/api/TreatmentPlans/$id',
      method: ApiMethod.get,
    );

    TreatmentPlanDetail? plan;

    result.either((success) {
      final data = success.data as Map<String, dynamic>;
      plan = TreatmentPlanDetail.fromJson(data);
    }, (error) {
      // TODO: handle error
    });

    return Future.value(plan);
  }
}
