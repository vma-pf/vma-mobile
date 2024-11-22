import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/treatment_guide.dart';
import 'package:vma/core/repositories/treatment_guide_repository.dart';

class TreatmentGuideModel extends Model {
  final TreatmentGuideRepository _repository = TreatmentGuideRepository();

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

  Future<List<TreatmentGuide>> _treatmentGuides = Future.value([]);
  Future<List<TreatmentGuide>> get treatmentGuides => _treatmentGuides;
  set treatmentGuides(Future<List<TreatmentGuide>> value) {
    _treatmentGuides = value;
    notifyListeners();
  }

  Future<TreatmentGuide?> _treatmentGuide = Future.value(null);
  Future<TreatmentGuide?> get treatmentGuide => _treatmentGuide;
  set treatmentGuide(Future<TreatmentGuide?> value) {
    _treatmentGuide = value;
    notifyListeners();
  }

  void loadData() async {
    final response = await _repository.get(pageSize, pageIndex);
    pageSize = response.pageSize;
    pageIndex = response.pageIndex;
    treatmentGuides = Future.value(response.data);
  }

  void loadDataById(id) async {
    final response = await _repository.getTreatmentGuideById(id);
    treatmentGuide = Future.value(response);
  }
}
