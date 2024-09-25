import 'package:vma/core/models/enums/pig_health_status.dart';

class MonitoringDevelopmentLog {
  final String id;
  final String cageId;
  final String cageCode;
  final DateTime checkupAt;
  final double weight;
  final double height;
  final double width;
  final PigHealthStatus healthStatus;

  MonitoringDevelopmentLog({
    required this.id,
    required this.cageId,
    required this.cageCode,
    required this.checkupAt,
    required this.weight,
    required this.height,
    required this.width,
    required this.healthStatus,
  });

  factory MonitoringDevelopmentLog.fromJson(Map<String, dynamic> json) {
    return MonitoringDevelopmentLog(
      id: json['id'],
      cageId: json['cageId'],
      cageCode: json['cageCode'],
      checkupAt: DateTime.parse(json['checkupAt']),
      weight: json['weight'],
      height: json['height'],
      width: json['width'],
      healthStatus: json['healthStatus'],
    );
  }
}
