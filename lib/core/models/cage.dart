class Cage {
  final String id;
  final String code;
  final String? description;
  final int capacity;
  final int availableQuantity;
  final String? cameraId;

  Cage({
    required this.id,
    required this.code,
    this.description,
    required this.capacity,
    required this.availableQuantity,
    this.cameraId,
  });

  factory Cage.fromJson(Map<String, dynamic> json) {
    return Cage(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      capacity: json['capacity'],
      availableQuantity: json['availableQuantity'],
      cameraId: json['cameraId'],
    );
  }
}
