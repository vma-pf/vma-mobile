import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/common_disease.dart';
import 'package:vma/core/repositories/common_disease_repository.dart';

class CommonDiseaseModel extends Model {
  final CommonDiseaseRepository _repository = CommonDiseaseRepository();

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

  Future<List<CommonDisease>> _commonDiseases = Future.value([]);
  Future<List<CommonDisease>> get commonDiseases => _commonDiseases;
  set commonDiseases(Future<List<CommonDisease>> value) {
    _commonDiseases = value;
    notifyListeners();
  }

  Future<CommonDisease?> _commonDisease = Future.value(null);
  Future<CommonDisease?> get commonDisease => _commonDisease;
  set commonDisease(Future<CommonDisease?> value) {
    _commonDisease = value;
    notifyListeners();
  }

  void loadData() async {
    final response = await _repository.get(pageSize, pageIndex);
    pageSize = response.pageSize;
    pageIndex = response.pageIndex;
    commonDiseases = Future.value(response.data);
  }

  void loadDataById(id) async {
    final response = await _repository.getCommonDiseaseById(id);
    commonDisease = Future.value(response);
  }
}
