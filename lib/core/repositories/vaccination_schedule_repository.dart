import 'package:vma/core/extensions/json_to_list_extension.dart';
import 'package:vma/core/models/vaccination_schedule.dart';
import 'package:vma/core/network/api.dart';

class VaccinationScheduleRepository {
  Future<List<VaccinationSchedule>> getVaccinationSchedules() async {
    final result = await ApiCaller.instance.request(
      path: '/api/my-schedule',
      method: ApiMethod.get,
    );

    List<VaccinationSchedule> schedules = [];

    result.either((success) {
      final data = success.data as List<dynamic>;
      schedules = data.fromJsonToList<VaccinationSchedule>(
        (e) => VaccinationSchedule.fromJson(e),
      );
    }, (error) {
      // handle error
    });

    return Future.value(schedules);
  }
}
