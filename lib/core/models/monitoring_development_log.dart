import 'package:vma/core/models/enums/pig_health_status.dart';
import 'package:vma/core/utils/enum_helper.dart';

class MonitoringDevelopmentLog {
  final String id;
  final DateTime checkupAt;
  final double weight;
  final double height;
  final double width;
  final PigHealthStatus healthStatus;

  MonitoringDevelopmentLog({
    required this.id,
    required this.checkupAt,
    required this.weight,
    required this.height,
    required this.width,
    required this.healthStatus,
  });

  factory MonitoringDevelopmentLog.fromJson(Map<String, dynamic> json) {
    return MonitoringDevelopmentLog(
      id: json['id'],
      checkupAt: DateTime.parse(json['checkUpAt']),
      weight: json['weight'],
      height: json['height'],
      width: json['width'],
      healthStatus:
          EnumHelper.jsonToEnum(PigHealthStatus.values, json['healthStatus']) ??
              PigHealthStatus.unknown,
    );
  }
}
