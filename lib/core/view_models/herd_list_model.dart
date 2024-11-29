import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/herd.dart';
import 'package:vma/core/repositories/herd_repository.dart';

class HerdListModel extends Model {
  final _repository = HerdRepository();

  Future<List<Herd>> _herds = Future.value([]);
  Future<List<Herd>> get herds => _herds;
  set herds(Future<List<Herd>> value) {
    _herds = value;
    notifyListeners();
  }

  void loadHerds() async {
    herds = _repository.getAllHerds();
  }
}
