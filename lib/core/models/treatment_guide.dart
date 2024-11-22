class TreatmentGuide {
  final String id;
  final String? diseaseTitle;
  final String? diseaseDescription;
  final String? diseaseSymptoms;
  final String? treatmentTitle;
  final String? treatmentDescription;
  final String? cure;
  final String? diseaseType;
  final String? authorName;

  TreatmentGuide({
    required this.id,
    this.diseaseTitle,
    this.diseaseDescription,
    this.diseaseSymptoms,
    this.treatmentTitle,
    this.treatmentDescription,
    this.cure,
    this.diseaseType,
    this.authorName,
  });

  factory TreatmentGuide.fromJson(Map<String, dynamic> json) {
    return TreatmentGuide(
      id: json['id'],
      diseaseTitle: json['diseaseTitle'],
      diseaseDescription: json['diseaseDescription'],
      diseaseSymptoms: json['diseaseSymptoms'],
      treatmentTitle: json['treatmentTitle'],
      treatmentDescription: json['treatmentDescription'],
      cure: json['cure'],
      diseaseType: json['diseaseType'],
      authorName: json['authorName'],
    );
  }
}
