import 'package:vma/core/models/enums/vaccination_plan_status.dart';
import 'package:vma/core/models/vaccination_plan.dart';

class VaccinationPlanRepository {
  Future<List<VaccinationPlan>> getAllVaccinationPlans() async {
    final plans = [
      VaccinationPlan(
        title: 'Vaccination Plan 1',
        description: 'Description 1',
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 12, 1),
        status: VaccinationPlanStatus.onGoing,
        note: 'Note 1',
        pigCount: 10,
      ),
      VaccinationPlan(
        title: 'Vaccination Plan 2',
        description: 'Description 2',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: VaccinationPlanStatus.onGoing,
        note: 'Note 2',
        pigCount: 20,
      ),
      VaccinationPlan(
        title: 'Vaccination Plan 3',
        description: 'Description 3',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: VaccinationPlanStatus.onGoing,
        note: 'Note 3',
        pigCount: 30,
      ),
    ];

    return plans;
  }
}
