import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/pig.dart';
import 'package:vma/core/repositories/pig_repository.dart';

class PigListModel extends Model {
  late PigRepository _repository;

  PigListModel() {
    _repository = PigRepository();
  }

  Future<List<Pig>> _pigs = Future.value([]);
  Future<List<Pig>> get pigs => _pigs;
  set pigs(Future<List<Pig>> value) {
    _pigs = value;
    notifyListeners();
  }

  Future<bool> loadPigs() async {
    List<Pig> pigList = await _repository.getAllPigs();
    pigs = Future.value(pigList);
    return pigList.isNotEmpty;
  }
}
