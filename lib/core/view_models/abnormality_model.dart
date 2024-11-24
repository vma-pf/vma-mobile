import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/abnormality.dart';
import 'package:vma/core/repositories/abnormality_repository.dart';

class AbnormalityModel extends Model {
  final _repository = AbnormalityRepository();

  Future<Abnormality?> _abnormality = Future.value(null);
  Future<Abnormality?> get abnormality => _abnormality;
  set abnormality(Future<Abnormality?> value) {
    _abnormality = value;
    notifyListeners();
  }

  Future<List<Abnormality>> _abnormalities = Future.value([]);
  Future<List<Abnormality>> get abnormalities => _abnormalities;
  set abnormalities(Future<List<Abnormality>> value) {
    _abnormalities = value;
    notifyListeners();
  }

  Future loadAbnormalities() async {
    final response = await _repository.getAllAbnormalities();
    abnormalities = Future.value(response);
  }

  Future loadAbnormality(String id) async {
    await loadAbnormalities();
    final list = await _abnormalities;
    try {
      final selectedAbnormality = list.firstWhere((e) => e.id == id);
      abnormality = Future.value(selectedAbnormality);
    } catch (e) {
      // TODO: Handle error
    }
  }
}
