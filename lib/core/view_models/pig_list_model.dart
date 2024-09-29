import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/pig.dart';
import 'package:vma/core/repositories/pig_repository.dart';

class PigListModel extends Model {
  late PigRepository _repository;

  PigListModel() {
    _repository = PigRepository();
  }

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

  Future<List<Pig>> _pigs = Future.value([]);
  Future<List<Pig>> get pigs => _pigs;
  set pigs(Future<List<Pig>> value) {
    _pigs = value;
    notifyListeners();
  }

  Future<void> loadPigs() async {
    final response = await _repository.getAllPigs(pageSize, pageIndex);
    pageSize = response.pageSize;
    pageIndex = response.pageIndex;
    pigs = Future.value(response.data);
  }
}
