import 'package:vma/core/models/notification.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class NotificationRepository {
  Future<List<Notification>> getAllNotifications() async {
    final query = {
      'pageIndex': 1,
      'pageSize': 999,
    };
    final result = await ApiCaller.instance.request(
      path: '/notifications',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<Notification> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: <Notification>[],
    );

    result.either(
      (success) {
        response = PaginatedResponse.fromJson(
          success.data,
          (e) => Notification.fromJson(e),
        );
      },
      (error) {
        // TODO: handle error
      },
    );

    return response.data;
  }
}
