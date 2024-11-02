import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/vaccination_schedules/widgets/schedule_details.dart';
import 'package:vma/core/view_models/vaccination_schedules_model.dart';
import 'package:vma/core/models/vaccination_schedule.dart' as models;

class VaccinationSchedule extends StatefulWidget {
  const VaccinationSchedule({super.key});

  @override
  State<VaccinationSchedule> createState() => _VaccinationScheduleState();
}

class _VaccinationScheduleState extends VMAState<VaccinationSchedule> {
  final VaccinationSchedulesModel _model = VaccinationSchedulesModel();

  late final ValueNotifier<List<models.VaccinationSchedule>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _model.focusedDate;
    _selectedEvents = ValueNotifier(_model.getSchedulesByDay(_selectedDay!));
    _model.loadVaccinationSchedules();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  List<models.VaccinationSchedule> _getEventsForRange(
    DateTime start,
    DateTime end,
  ) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._model.getSchedulesByDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _model.focusedDate = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _model.getSchedulesByDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _model.focusedDate = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _model.getSchedulesByDay(start);
    } else if (end != null) {
      _selectedEvents.value = _model.getSchedulesByDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch tiêm phòng'),
      ),
      body: ScopedModel(
        model: _model,
        child: ScopedModelDescendant<VaccinationSchedulesModel>(
          builder: (context, child, model) {
            return Column(
              children: [
                TableCalendar<models.VaccinationSchedule>(
                  firstDay: _model.firstDate,
                  lastDay: _model.lastDate,
                  focusedDay: _model.focusedDate,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _model.getSchedulesByDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _model.focusedDate = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child:
                      ValueListenableBuilder<List<models.VaccinationSchedule>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final models.VaccinationSchedule schedule =
                              value[index];
                          return ScheduleDetails(schedule: schedule);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
