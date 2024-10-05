import 'package:vma/core/models/enums/medicine_status.dart';

class MedicineStatusTransformer {
  static String tranformToText(MedicineStatus status) {
    switch (status) {
      case MedicineStatus.pending:
        return 'Đang chờ';
      case MedicineStatus.requested:
        return 'Đã yêu cầu';
      case MedicineStatus.approved:
        return 'Được chấp nhận';
      case MedicineStatus.rejected:
        return 'Bị từ chối';
      case MedicineStatus.unknown:
        return 'Không rõ';
    }
  }
}
