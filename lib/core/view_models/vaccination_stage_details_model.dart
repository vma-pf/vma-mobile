import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/medicines_requested_event.dart';
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

  bool _canUpdateStage = false;
  bool get canUpdateStage => _canUpdateStage;
  set canUpdateStage(bool value) {
    _canUpdateStage = value;
    notifyListeners();
  }

  bool _canRequestMedicines = false;
  bool get canRequestMedicines => _canRequestMedicines;
  set canRequestMedicines(bool value) {
    _canRequestMedicines = value;
    notifyListeners();
  }

  bool _isStageDone = false;
  bool get isStageDone => _isStageDone;
  set isStageDone(bool value) {
    _isStageDone = value;
    notifyListeners();
  }

  void loadMedicines(String stageId) async {
    final result = await _repository.getMedicinesByStageId(stageId);
    canRequestMedicines =
        result.any((element) => element.status == "Chờ xử lý");
    canUpdateStage = !canRequestMedicines &&
        result.every((element) => element.status == "Đã duyệt");
    medicines = Future.value(result);
  }

  void updateVaccinationStage(Set<String> pigIds, String stageId) {
    // TODO: call api
    _repository.updateVaccinationStage(stageId, pigIds.toList());
    final updateEvent = VaccinationStageUpdatedEvent(success: true);
    EventManager.fire(updateEvent);
  }

  void requestMedicines() {
    medicines.then((value) {
      final medicinesToRequest = value
          .where((element) => element.status == "Chờ xử lý")
          .map((e) => e.id);
      _repository.requestMedicines(medicinesToRequest.toList());
    }).whenComplete(() {
      final requestEvent = MedicinesRequestedEvent(success: true);
      EventManager.fire(requestEvent);
    }).catchError((obj) {
      final requestEvent = MedicinesRequestedEvent(success: false);
      EventManager.fire(requestEvent);
    });
  }
}
