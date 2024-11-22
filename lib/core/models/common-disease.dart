class CommonDisease {
  final String id;
  final String? title;
  final String? description;
  final String? symptom;
  final String? treatment;
  final String? diseaseType;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;

  CommonDisease({
    required this.id,
    this.title,
    this.description,
    this.symptom,
    this.treatment,
    this.diseaseType,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  factory CommonDisease.fromJson(Map<String, dynamic> json) {
    return CommonDisease(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      symptom: json['symptom'],
      treatment: json['treatment'],
      diseaseType: json['diseaseType'],
      createdAt: DateTime.parse(json['createdAt']),
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt']),
    );
  }
}
