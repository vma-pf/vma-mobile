class VaccinationPlan {
  final String id;
  final String title;
  final String? description;
  final String note;
  final DateTime startDate;
  final DateTime expectedEndDate;
  final String? status;
  final int pigCount;

  VaccinationPlan({
    required this.id,
    required this.title,
    this.description,
    required this.note,
    required this.startDate,
    required this.expectedEndDate,
    this.status,
    required this.pigCount,
  });

  factory VaccinationPlan.fromJson(Map<String, dynamic> json) {
    return VaccinationPlan(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      note: json['note'],
      startDate: DateTime.parse(json['startDate']),
      expectedEndDate: DateTime.parse(json['expectedEndDate']),
      status: json['status'],
      pigCount: json['pigCount'],
    );
  }
}
