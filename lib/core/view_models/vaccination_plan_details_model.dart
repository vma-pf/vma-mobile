import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/vaccination_plan_details.dart';
import 'package:vma/core/repositories/vaccination_plan_repository.dart';

class VaccinationPlanDetailsModel extends Model {
  final VaccinationPlanRepository _repository = VaccinationPlanRepository();

  Future<VaccinationPlanDetails?> _plan = Future.value(null);
  Future<VaccinationPlanDetails?> get plan => _plan;
  set plan(Future<VaccinationPlanDetails?> value) {
    _plan = value;
    notifyListeners();
  }

  void loadPlan(String id) async {
    plan = _repository.getPlanById(id);
  }
}
