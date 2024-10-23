class MedicineRequest {
  final String id;
  final String? medicineId;
  final String inventoryRequestId;
  final String status;
  final int quantity;
  final String? newMedicineName;
  final bool isPurchaseNeeded;

  MedicineRequest({
    required this.id,
    this.medicineId,
    required this.inventoryRequestId,
    required this.status,
    required this.quantity,
    this.newMedicineName,
    required this.isPurchaseNeeded,
  });

  factory MedicineRequest.fromJson(Map<String, dynamic> json) {
    return MedicineRequest(
      id: json['id'],
      medicineId: json['medicineId'],
      inventoryRequestId: json['inventoryRequestId'],
      status: json['status'],
      quantity: json['quantity'],
      newMedicineName: json['newMedicineName'],
      isPurchaseNeeded: json['isPurchaseNeeded'],
    );
  }
}
