import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/pig.dart';

class PigListModel extends Model {
  Future<List<Pig>> _pigs = Future.value([]);
  Future<List<Pig>> get pigs => _pigs;
  set pigs(Future<List<Pig>> value) {
    _pigs = value;
    notifyListeners();
  }

  Future<bool> setPigs() async {
    await Future.delayed(const Duration(seconds: 3));
    List<Pig> pigList = [
      Pig(weight: 1, name: "Pig 1"),
      Pig(weight: 2, name: "Pig 2"),
      Pig(weight: 3, name: "Pig 3"),
      Pig(weight: 4, name: "Pig 4"),
      Pig(weight: 5, name: "Pig 5"),
    ];
    pigs = Future.value(pigList);
    return pigList.isNotEmpty;
  }
}
