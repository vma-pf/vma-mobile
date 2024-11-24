class Abnormality {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String abnormalityType;
  final String imageUrl;
  final String cageCode;

  Abnormality({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.abnormalityType,
    required this.imageUrl,
    required this.cageCode,
  });

  factory Abnormality.fromJson(Map<String, dynamic> json) {
    return Abnormality(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      abnormalityType: json['abnormalityType'],
      imageUrl: json['imageUrl'],
      cageCode: json['cageCode'],
    );
  }
}
