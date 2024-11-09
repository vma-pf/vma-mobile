import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/pig_vaccination_stage_for_stage_detail.dart';
import 'package:vma/core/repositories/vaccination_stage_repository.dart';

class UpdateVaccinationStageModel extends Model {
  final VaccinationStageRepository _vaccinationStageRepository =
      VaccinationStageRepository();

  int _pageIndex = 1;
  int get pageIndex => _pageIndex;
  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  int _pageSize = 10;
  int get pageSize => _pageSize;
  set pageSize(int value) {
    _pageSize = value;
    notifyListeners();
  }

  Future<List<PigVaccinationStageForStageDetail>> _stages = Future.value([]);
  Future<List<PigVaccinationStageForStageDetail>> get stages => _stages;
  set stages(Future<List<PigVaccinationStageForStageDetail>> value) {
    _stages = value;
    notifyListeners();
  }

  Future loadVaccinationStage(String stageId) async {
    final paginatedResponse =
        await _vaccinationStageRepository.getPigVaccinationStagesByStageId(
      stageId,
      pageIndex,
      pageSize,
    );
    stages = Future.value(paginatedResponse.data);
  }
}
