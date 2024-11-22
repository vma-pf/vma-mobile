import 'package:vma/core/models/notification.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/extensions/json_to_list_extension.dart';

class NotificationRepository {
  Future<List<Notification>> getAllNotifications() async {
    final result = await ApiCaller.instance.request(
      path: '/notifications',
      method: ApiMethod.get,
    );

    List<Notification> notifcations = [];

    result.either(
      (success) {
        notifcations = (success.data as List<dynamic>)
            .fromJsonToList<Notification>((e) => Notification.fromJson(e));
      },
      (error) {
        // TODO: handle error
      },
    );

    return notifcations;
  }
}
