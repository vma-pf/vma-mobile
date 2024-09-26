import 'package:vma/core/models/enums/vaccination_plan_status.dart';

class VaccinationPlanStatusTranformer {
  static String transformToText(VaccinationPlanStatus status) {
    switch (status) {
      case VaccinationPlanStatus.onGoing:
        return 'On Going';
      case VaccinationPlanStatus.completed:
        return 'Completed';
      case VaccinationPlanStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
