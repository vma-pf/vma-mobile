import 'package:vma/core/models/common-disease.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class CommonDiseaseRepository {
  Future<PaginatedResponse<CommonDisease>> get(
    int pageSize,
    int pageIndex,
  ) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/api/CommonDiseases',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<CommonDisease> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => CommonDisease.fromJson(e),
      );
    }, (error) {
      // TODO: handle error
    });

    return response;
  }
}
