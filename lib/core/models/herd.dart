class Herd {
  final String id;
  final bool isCheckUpToday;
  final String breed;
  final int totalNumber;
  final String status;
  final DateTime expectedEndDate;
  final DateTime actualEndDate;
  final DateTime startDate;
  final double averageWeight;
  final String code;
  final String description;

  Herd({
    required this.id,
    required this.isCheckUpToday,
    required this.breed,
    required this.totalNumber,
    required this.status,
    required this.expectedEndDate,
    required this.actualEndDate,
    required this.startDate,
    required this.averageWeight,
    required this.code,
    required this.description,
  });

  factory Herd.fromJson(Map<String, dynamic> json) {
    return Herd(
      id: json['id'],
      isCheckUpToday: json['isCheckUpToday'],
      breed: json['breed'],
      totalNumber: json['totalNumber'],
      status: json['status'],
      expectedEndDate: DateTime.parse(json['expectedEndDate']),
      actualEndDate: DateTime.parse(json['actualEndDate']),
      startDate: DateTime.parse(json['startDate']),
      averageWeight: json['averageWeight'],
      code: json['code'],
      description: json['description'],
    );
  }
}
