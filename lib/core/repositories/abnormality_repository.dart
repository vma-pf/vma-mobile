import 'package:vma/core/models/abnormality.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class AbnormalityRepository {
  Future<List<Abnormality>> getAllAbnormalities({
    int pageSize = 999,
    int pageIndex = 1,
  }) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };

    final result = await ApiCaller.instance.request(
      path: '/api/Abnormalities',
      method: ApiMethod.get,
      queryParams: query,
    );

    List<Abnormality> response = [];

    result.either((success) {
      final paginatedResponse = PaginatedResponse.fromJson(
        success.data,
        (e) => Abnormality.fromJson(e),
      );
      response = paginatedResponse.data;
    }, (error) {
      // TODO: handle error
    });

    return response;
  }

  Future<Abnormality?> getAbnormalityById(String id) async {
    final result = await ApiCaller.instance.request(
      path: '/api/Abnormalities/$id',
      method: ApiMethod.get,
    );

    Abnormality? response;

    result.either((success) {
      response = Abnormality.fromJson(success.data);
    }, (error) {
      // TODO: handle error
    });

    return response;
  }
}
