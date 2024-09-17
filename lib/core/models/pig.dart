class Pig {
  String id;
  String breed;
  String herdId;
  String cageId;
  double weight;
  double height;
  double width;
  DateTime lastUpdated;
  String healthStatus;
  DateTime nextVaccinationDate;

  Pig({
    required this.id,
    required this.breed,
    required this.herdId,
    required this.cageId,
    required this.weight,
    required this.height,
    required this.width,
    required this.lastUpdated,
    required this.healthStatus,
    required this.nextVaccinationDate,
  });

  factory Pig.fromJson(Map<String, dynamic> json) {
    return Pig(
      id: json['id'],
      breed: json['breed'],
      herdId: json['herdId'],
      cageId: json['cageId'],
      weight: json['weight'],
      height: json['height'],
      width: json['width'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      healthStatus: json['healthStatus'],
      nextVaccinationDate: DateTime.parse(json['nextVaccinationDate']),
    );
  }
}
