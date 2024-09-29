import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/pig_detail.dart';
import 'package:vma/core/repositories/pig_repository.dart';

class PigDetailModel extends Model {
  late PigRepository _repository;

  Future<PigDetail?> _pig = Future.value(null);
  Future<PigDetail?> get pig => _pig;
  set pig(Future<PigDetail?> value) {
    _pig = value;
    notifyListeners();
  }

  PigDetailModel() {
    _repository = PigRepository();
  }

  Future<void> loadPig(String id) async {
    pig = _repository.getPigById(id);
  }
}
