import 'package:vma/core/models/enums/medicine_status.dart';
import 'package:vma/core/utils/enum_helper.dart';

class Medicine {
  final String id;
  final String medicineName;
  final int quantity;
  final MedicineStatus status;

  Medicine({
    required this.id,
    required this.medicineName,
    required this.quantity,
    required this.status,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as String,
      medicineName: json['medicineName'] as String,
      quantity: json['quantity'] as int,
      status: EnumHelper.jsonToEnum(MedicineStatus.values, json['status']) ??
          MedicineStatus.unknown,
    );
  }
}
