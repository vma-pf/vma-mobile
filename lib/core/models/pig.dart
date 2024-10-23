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
  final String healthStatus;
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
      healthStatus: json['healthStatus'],
      vaccinationDate: DateTime.parse(json['vaccinationDate']),
    );
  }
}
