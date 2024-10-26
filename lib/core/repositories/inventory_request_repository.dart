import 'package:vma/core/models/inventory_request.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class InventoryRequestRepository {
  Future<PaginatedResponse<InventoryRequest>> getMyMedicineRequests(
    int pageSize,
    int pageIndex,
  ) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/api/InventoryRequests/my-inventory-requests',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<InventoryRequest> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => InventoryRequest.fromJson(e),
      );
    }, (error) {
      // TODO: handle error
    });

    return response;
  }
}
