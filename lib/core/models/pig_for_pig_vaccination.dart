class PigForPigVaccination {
  final String id;
  final String breed;
  final String herdId;
  final String cageCode;
  final String healthStatus;
  final String pigCode;

  PigForPigVaccination({
    required this.id,
    required this.breed,
    required this.herdId,
    required this.cageCode,
    required this.healthStatus,
    required this.pigCode,
  });

  factory PigForPigVaccination.fromJson(Map<String, dynamic> json) {
    return PigForPigVaccination(
      id: json['id'],
      breed: json['breed'],
      herdId: json['herdId'],
      cageCode: json['cageCode'],
      healthStatus: json['healthStatus'],
      pigCode: json['pigCode'],
    );
  }
}
