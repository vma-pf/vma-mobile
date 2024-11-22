import 'package:vma/core/models/cage.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class CageRepository {
  Future<PaginatedResponse<Cage>> getAllCages({
    int pageSize = 999,
    int pageIndex = 1,
  }) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/api/Cages',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<Cage> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => Cage.fromJson(e),
      );
    }, (error) {
      // TODO: handle error
    });

    return Future.value(response);
  }
}
