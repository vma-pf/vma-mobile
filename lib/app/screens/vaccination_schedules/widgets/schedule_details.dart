import 'package:flutter/material.dart';
import 'package:vma/core/models/vaccination_schedule.dart';
import 'package:vma/core/utils/date_time_helper.dart';

class ScheduleDetails extends StatelessWidget {
  final VaccinationSchedule schedule;

  const ScheduleDetails({super.key, required this.schedule});

  Color _getScheduleStatusColor() {
    if (schedule.isDone) {
      return Colors.green;
    }

    return Colors.red;
  }

  String _getScheduleStatusText() {
    if (schedule.isDone) {
      return 'Đã hoàn thành';
    }

    return 'Chưa hoàn thành';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schedule.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Thời gian bắt đầu: ${DateTimeHelper.getFormattedDateTime(schedule.start)}',
            ),
            Text(
              'Thời gian kết thúc: ${DateTimeHelper.getFormattedDateTime(schedule.end)}',
            ),
            Text(
              _getScheduleStatusText(),
              style: TextStyle(
                color: _getScheduleStatusColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
