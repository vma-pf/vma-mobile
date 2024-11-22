import 'package:vma/core/models/treatment_guide.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class TreatmentGuideRepository {
  Future<PaginatedResponse<TreatmentGuide>> get(
    int pageSize,
    int pageIndex,
  ) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/api/TreatmentGuides',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<TreatmentGuide> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => TreatmentGuide.fromJson(e),
      );
    }, (error) {});

    return response;
  }

  Future<TreatmentGuide> getTreatmentGuideById(String id) async {
    final result = await ApiCaller.instance.request(
      path: '/TreatmentGuides/$id',
      method: ApiMethod.get,
    );

    TreatmentGuide? plan;

    result.either((success) {
      final data = success.data as Map<String, dynamic>;
      plan = TreatmentGuide.fromJson(data);
    }, (error) {});

    return Future.value(plan);
  }
}
