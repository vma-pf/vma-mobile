class InventoryRequest {
  final String requestId;
  final String? vaccinactionStageId;
  final String? treatmentStageId;

  final String? title;
  final String? description;
  final String status;
  final DateTime createdAt;
  final String id;

  InventoryRequest({
    required this.requestId,
    this.vaccinactionStageId,
    this.treatmentStageId,
    this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.id,
  });

  factory InventoryRequest.fromJson(Map<String, dynamic> json) {
    return InventoryRequest(
      requestId: json['requesterId'],
      vaccinactionStageId: json['vaccinationStageId'],
      treatmentStageId: json['treatmentStageId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      id: json['id'],
    );
  }
}
