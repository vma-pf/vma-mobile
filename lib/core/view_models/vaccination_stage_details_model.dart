import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/vaccination_stage_updated_event.dart';
import 'package:vma/core/models/medicine.dart';
import 'package:vma/core/repositories/vaccination_plan_repository.dart';

class VaccinationStageDetailsModel extends Model {
  final _repository = VaccinationPlanRepository();

  Future<List<Medicine>> _medicines = Future.value([]);
  Future<List<Medicine>> get medicines => _medicines;
  set medicines(Future<List<Medicine>> value) {
    _medicines = value;
    notifyListeners();
  }

  void loadMedicines(String stageId) async {
    medicines = _repository.getMedicinesByStageId(stageId);
  }

  void updateVaccinationStage(Set<String> pigIds, String stageId) {
    // TODO: call api
    _repository.updateVaccinationStage(stageId, pigIds.toList());
    final updateEvent = VaccinationStageUpdatedEvent(success: true);
    EventManager.fire(updateEvent);
  }
}
