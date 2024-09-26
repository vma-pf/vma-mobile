import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/vaccination_plan.dart';
import 'package:vma/core/repositories/vaccination_plan_repository.dart';

class VaccinationPlanDetailsModel extends Model {
  final VaccinationPlanRepository _repository = VaccinationPlanRepository();

  Future<VaccinationPlan?> _plan = Future.value(null);
  Future<VaccinationPlan?> get plan => _plan;
  set plan(Future<VaccinationPlan?> value) {
    _plan = value;
    notifyListeners();
  }

  void loadPlan(String id) async {
    VaccinationPlan? plan = await _repository.getPlanById(id);
    this.plan = Future.value(plan);
  }
}
