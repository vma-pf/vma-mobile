import 'package:vma/core/models/enums/vaccination_plan_status.dart';

class VaccinationPlanStatusTranformer {
  static String transformToText(VaccinationPlanStatus status) {
    switch (status) {
      case VaccinationPlanStatus.onGoing:
        return 'Đang diễn ra';
      case VaccinationPlanStatus.completed:
        return 'Đã hoàn thành';
      case VaccinationPlanStatus.cancelled:
        return 'Đã hủy';
      default:
        return 'Không rõ';
    }
  }
}
