import 'package:vma/core/models/herd.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class HerdRepository {
  Future<List<Herd>> getAllHerds() async {
    final params = {
      'pageIndex': 1,
      'pageSize': 999,
    };
    final result = await ApiCaller.instance.request(
      path: '/api/Herds',
      method: ApiMethod.get,
      queryParams: params,
    );

    PaginatedResponse<Herd> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 999,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => Herd.fromJson(e),
      );
    }, (error) {
      // TODO: handle error
    });

    return response.data;
  }
}
