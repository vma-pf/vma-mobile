class TreatmentPlan {
  final String id;
  final String description;
  final String title;
  final String note;
  final DateTime createdAt;
  final String status;

  TreatmentPlan({
    required this.id,
    required this.description,
    required this.title,
    required this.note,
    required this.createdAt,
    required this.status,
  });

  factory TreatmentPlan.fromJson(Map<String, dynamic> json) {
    return TreatmentPlan(
      id: json['id'],
      description: json['description'],
      title: json['title'],
      note: json['note'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }
}
