import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/vaccination_schedule.dart';
import 'package:vma/core/repositories/vaccination_schedule_repository.dart';

class VaccinationSchedulesModel extends Model {
  final VaccinationScheduleRepository _repository =
      VaccinationScheduleRepository();

  List<VaccinationSchedule> _schedules = [];
  List<VaccinationSchedule> get schedules => _schedules;
  set schedules(List<VaccinationSchedule> value) {
    _schedules = value;
    notifyListeners();
  }

  DateTime _firstDate = DateTime.now();
  DateTime get firstDate => _firstDate;
  set firstDate(DateTime value) {
    _firstDate = value;
    notifyListeners();
  }

  DateTime _lastDate = DateTime.now();
  DateTime get lastDate => _lastDate;
  set lastDate(DateTime value) {
    _lastDate = value;
    notifyListeners();
  }

  DateTime _focusedDate = DateTime.now();
  DateTime get focusedDate => _focusedDate;
  set focusedDate(DateTime value) {
    _focusedDate = value;
    notifyListeners();
  }

  void loadVaccinationSchedules() async {
    List<VaccinationSchedule> receivedSchedules =
        await _repository.getVaccinationSchedules();
    receivedSchedules
        .sort((current, next) => current.start.compareTo(next.end));

    schedules = receivedSchedules;
    if (receivedSchedules.isEmpty) {
      final today = DateTime.now();
      final firstDayOfTheMonth = DateTime(today.year, today.month, 1);
      final lastDayOfTheMonth = DateTime(today.year, today.month + 1, 0);
      firstDate = firstDayOfTheMonth;
      lastDate = lastDayOfTheMonth;
    } else {
      final earliestDate = receivedSchedules.first.start;
      final latestDate = receivedSchedules.last.start;
      final firstDayOfTheMonth =
          DateTime(earliestDate.year, earliestDate.month, 1);
      final lastDayOfTheMonth =
          DateTime(latestDate.year, latestDate.month + 1, 0);

      focusedDate = focusedDate.isBefore(lastDayOfTheMonth)
          ? focusedDate
          : lastDayOfTheMonth;

      firstDate = firstDayOfTheMonth;
      lastDate = lastDayOfTheMonth;
    }
  }

  List<VaccinationSchedule> getSchedulesByDay(DateTime day) {
    final schedulesByDay = schedules
        .where(
          (schedule) =>
              schedule.start.year == day.year &&
              schedule.start.month == day.month &&
              schedule.start.day == day.day,
        )
        .toList();
    schedulesByDay.sort((current, next) => current.start.compareTo(next.start));

    return schedulesByDay;
  }
}
