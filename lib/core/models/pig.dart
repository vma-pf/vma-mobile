import 'package:vma/core/models/enums/pig_health_status.dart';

class Pig {
  final String id;
  final String breed;
  final String herdId;
  final String cageId;
  final String pigCode;
  final String? cageCode;
  final double weight;
  final double height;
  final double width;
  final DateTime lastUpdatedAt;
  final PigHealthStatus healthStatus;
  final DateTime vaccinationDate;

  Pig({
    required this.id,
    required this.breed,
    required this.herdId,
    required this.cageId,
    required this.pigCode,
    required this.cageCode,
    required this.weight,
    required this.height,
    required this.width,
    required this.lastUpdatedAt,
    required this.healthStatus,
    required this.vaccinationDate,
  });

  factory Pig.fromJson(Map<String, dynamic> json) {
    return Pig(
      id: json['id'],
      breed: json['breed'],
      herdId: json['herdId'],
      cageId: json['cageId'],
      pigCode: json['pigCode'],
      cageCode: json['cageCode'],
      weight: json['weight'],
      height: json['height'],
      width: json['width'],
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt']),
      healthStatus: PigHealthStatus.normal,
      // TODO: Uncomment this line to use the health status from the API when API is ready
      // healthStatus:
      //     EnumHelper.jsonToEnum(PigHealthStatus.values, json['healthStatus']) ??
      //         PigHealthStatus.unknown,
      vaccinationDate: DateTime.parse(json['vaccinationDate']),
    );
  }
}
