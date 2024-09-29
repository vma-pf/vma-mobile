import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/repositories/vaccination_plan_repository.dart';

class VaccinationPlanListModel extends Model {
  final VaccinationPlanRepository _repository = VaccinationPlanRepository();

  Future<List<VaccinationPlan>> _vaccinationPlans = Future.value([]);
  Future<List<VaccinationPlan>> get vaccinationPlans => _vaccinationPlans;
  set vaccinationPlans(Future<List<VaccinationPlan>> value) {
    _vaccinationPlans = value;
    notifyListeners();
  }

  Future<void> loadVaccinationPlans(String herdId) async {
    final plans = _repository.getVaccinationPlansByHerd(herdId);
    vaccinationPlans = plans;
  }
}
