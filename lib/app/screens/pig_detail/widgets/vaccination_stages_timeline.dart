import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vma/core/models/pig_vaccination_stage.dart';
import 'package:vma/core/utils/date_time_helper.dart';

class VaccinationStagesTimeline extends StatelessWidget {
  final List<PigVaccinationStage> vaccinationStages;
  const VaccinationStagesTimeline({super.key, required this.vaccinationStages});

  Color _getLineColorByDateTime(DateTime dateTime) {
    bool isTimeInThePast = dateTime.isBefore(DateTime.now());
    if (isTimeInThePast) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  Color _getIndicatorColorByDateTimeAndStatus(DateTime dateTime, bool isDone) {
    bool isTimeInThePast = dateTime.isBefore(DateTime.now());
    if (isTimeInThePast) {
      if (isDone) {
        return Colors.green;
      }
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  String _getStatusStringByDateTimeAndStatus(DateTime dateTime, bool isDone) {
    bool isTimeInThePast = dateTime.isBefore(DateTime.now());
    if (isTimeInThePast) {
      if (isDone) {
        return 'Đã tiêm';
      }
      return 'Chưa tiêm';
    } else {
      return 'Sắp tới';
    }
  }

  String _getIndicatorIconByDateTimeAndStatus(DateTime dateTime, bool isDone) {
    bool isTimeInThePast = dateTime.isBefore(DateTime.now());
    if (isTimeInThePast) {
      if (isDone) {
        return '✓';
      }
      return '✗';
    } else {
      return '';
    }
  }

  void _sortVaccinationStagesByApplyTime() {
    vaccinationStages
        .sort((a, b) => a.applyStageTime.compareTo(b.applyStageTime));
  }

  @override
  Widget build(BuildContext context) {
    _sortVaccinationStagesByApplyTime();

    return Column(
      children: [
        const SizedBox(height: 25),
        Text(
          'Giai đoạn tiêm chủng',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: vaccinationStages.length,
          itemBuilder: (context, index) {
            PigVaccinationStage stage = vaccinationStages[index];
            return TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.3,
              isFirst: index == 0,
              isLast: index == vaccinationStages.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 20,
                height: 20,
                indicator: Container(
                  decoration: BoxDecoration(
                    color: _getIndicatorColorByDateTimeAndStatus(
                      stage.applyStageTime,
                      stage.isDone,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _getIndicatorIconByDateTimeAndStatus(
                        stage.applyStageTime,
                        stage.isDone,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              afterLineStyle: LineStyle(
                color: _getLineColorByDateTime(stage.applyStageTime),
              ),
              beforeLineStyle: LineStyle(
                color: _getLineColorByDateTime(stage.applyStageTime),
              ),
              endChild: Container(
                constraints: const BoxConstraints(minHeight: 100),
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giai đoạn ${index + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ngày: ${DateTimeHelper.getFormattedDate(stage.applyStageTime)}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _getIndicatorColorByDateTimeAndStatus(
                            stage.applyStageTime,
                            stage.isDone,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _getStatusStringByDateTimeAndStatus(
                            stage.applyStageTime,
                            stage.isDone,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
