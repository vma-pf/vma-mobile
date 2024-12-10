import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/treatment_plan_detail.dart';
import 'package:vma/core/repositories/treatment_plan_repository.dart';

class TreatmentPlanDetailModel extends Model {
  final _repository = TreatmentPlanRepository();

  Future<TreatmentPlanDetail?> _plan = Future.value(null);
  Future<TreatmentPlanDetail?> get plan => _plan;
  set plan(Future<TreatmentPlanDetail?> value) {
    _plan = value;
    notifyListeners();
  }

  Future<void> loadPlan(String planId) async {
    plan = _repository.getPlanById(planId);
  }
}
