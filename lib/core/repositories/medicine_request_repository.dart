import 'package:vma/core/models/medicine_request.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class MedicineRequestRepository {
  Future<PaginatedResponse<MedicineRequest>> getMyMedicineRequests(
    int pageSize,
    int pageIndex,
  ) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/api/Pigs',
      method: ApiMethod.get,
      queryParams: query,
    );

    assert(result.isRight);

    PaginatedResponse<MedicineRequest> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    return response;
  }
}
