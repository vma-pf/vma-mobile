import 'package:flutter/material.dart';
import 'package:vma/app/screens/pig_detail/widgets/growth_metrics.dart';
import 'package:vma/app/screens/pig_detail/widgets/vaccination_stages_timeline.dart';
import 'package:vma/core/constants/pig_health_statuses.dart';
import 'package:vma/core/models/monitoring_development_log.dart';
import 'package:vma/core/models/pig_detail.dart';
import 'package:vma/core/utils/string_helper.dart';

class DetailInfo extends StatelessWidget {
  final PigDetail pigDetail;
  const DetailInfo({super.key, required this.pigDetail});

  Icon _getIconByGender() {
    if (pigDetail.gender.toLowerCase() == 'male') {
      return const Icon(Icons.male, color: Colors.blue);
    } else {
      return const Icon(Icons.female, color: Colors.pink);
    }
  }

  Color _getColorByStatus() {
    switch (pigDetail.status) {
      case PigHealthStatuses.alive:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  List<(double, double)> _getAttributesOverTime(String attribute) {
    int compareByCheckupAt(
      MonitoringDevelopmentLog currentLog,
      MonitoringDevelopmentLog nextLog,
    ) {
      return currentLog.checkupAt.millisecondsSinceEpoch -
          nextLog.checkupAt.millisecondsSinceEpoch;
    }

    double getAttributeValue(MonitoringDevelopmentLog log) {
      switch (attribute) {
        case 'weight':
          return log.weight;
        case 'height':
          return log.height;
        case 'width':
          return log.width;
        default:
          return 0;
      }
    }

    var copiedLogs = List<MonitoringDevelopmentLog>.from(
      pigDetail.monitoringDevelopmentLogs,
    );
    Map<String, MonitoringDevelopmentLog> latestPerMonth = {};

    for (var log in copiedLogs) {
      String key = "${log.checkupAt.year}-${log.checkupAt.month}";
      if (!latestPerMonth.containsKey(key) ||
          log.checkupAt.isAfter(latestPerMonth[key]!.checkupAt)) {
        latestPerMonth[key] = log;
      }
    }
    copiedLogs = latestPerMonth.values.toList();
    copiedLogs.sort(compareByCheckupAt);
    final points = copiedLogs
        .asMap()
        .entries
        .map((log) => (log.key.toDouble() + 1, getAttributeValue(log.value)))
        .toList();

    return points;
  }

  List<int> _getCheckupMonths() {
    final earliestCheckup = pigDetail.monitoringDevelopmentLogs
        .reduce((a, b) => a.checkupAt.isBefore(b.checkupAt) ? a : b);
    final latestCheckup = pigDetail.monitoringDevelopmentLogs
        .reduce((a, b) => a.checkupAt.isAfter(b.checkupAt) ? a : b);
    DateTime start = earliestCheckup.checkupAt;
    DateTime end = latestCheckup.checkupAt;

    List<int> months = [];
    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      months.add(start.month);
      start = DateTime(start.year, start.month + 1); // Move to the next month
    }

    return months;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Chi tiết heo',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              pigDetail.code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Giống:'),
                    Text(pigDetail.breed),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Giới tính:'),
                    Row(
                      children: [
                        Text(pigDetail.gender),
                        _getIconByGender(),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Trạng thái:'),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: _getColorByStatus(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        child: Text(
                          StringHelper.capitalize(pigDetail.status),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Chuồng:'),
                    Text(
                      pigDetail.currentCageCode,
                    ),
                  ],
                ),
                GrowthMetrics(
                  months: _getCheckupMonths(),
                  maxWeight: 150,
                  weightPoints: _getAttributesOverTime('weight'),
                  heightPoints: _getAttributesOverTime('height'),
                  widthPoints: _getAttributesOverTime('width'),
                ),
                SizedBox(
                  child: VaccinationStagesTimeline(
                    vaccinationStages: pigDetail.pigVaccinationStages,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
