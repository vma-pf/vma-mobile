import 'package:vma/core/models/pig.dart';
import 'package:vma/core/models/pig_detail.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class PigRepository {
  Future<PaginatedResponse<Pig>> getAllPigs(
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

    PaginatedResponse<Pig> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => Pig.fromJson(e),
      );
    }, (error) {
      // TODO: handle error
    });

    return Future.value(response);
  }

  Future<PigDetail?> getPigById(String id) async {
    var result = await ApiCaller.instance
        .request(path: '/api/Pigs/$id', method: ApiMethod.get);

    PigDetail? pig;

    result.either((success) {
      pig = PigDetail.fromJson(success.data);
    }, (error) {
      // TODO: handle error
    });

    return Future.value(pig);
  }
}
