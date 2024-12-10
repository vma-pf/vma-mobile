import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/treatment_plan.dart';
import 'package:vma/core/repositories/treatment_plan_repository.dart';

class TreatmentPlanListModel extends Model {
  final _repository = TreatmentPlanRepository();

  Future<List<TreatmentPlan>> _treatmentPlans = Future.value([]);
  Future<List<TreatmentPlan>> get treatmentPlans => _treatmentPlans;
  set treatmentPlans(Future<List<TreatmentPlan>> value) {
    _treatmentPlans = value;
    notifyListeners();
  }

  Future<void> loadTreatmentPlans() async {
    treatmentPlans = _repository.getAllTreatmentPlans();
  }
}
