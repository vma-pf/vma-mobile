import 'package:vma/core/models/pig_vaccination_stage_for_stage_detail.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class VaccinationStageRepository {
  Future<PaginatedResponse<PigVaccinationStageForStageDetail>>
      getPigVaccinationStagesByStageId(
    String vaccnationStageId,
    int pageIndex,
    int pageSize,
  ) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/vaccination-stages/$vaccnationStageId/pig-vaccination-stages',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<PigVaccinationStageForStageDetail> response =
        PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => PigVaccinationStageForStageDetail.fromJson(e),
      );
    }, (error) {
      // handle error
    });

    return Future.value(response);
  }
}
