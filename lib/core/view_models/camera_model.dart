import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/constants/api.dart';
import 'package:vma/core/models/cage.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/repositories/cage_repository.dart';

class CameraModel extends Model {
  final _repository = CageRepository();

  Future<List<Cage>> _cages = Future.value([]);
  Future<List<Cage>> get cages => _cages;
  set cages(Future<List<Cage>> value) {
    _cages = value;
    notifyListeners();
  }

  Future<void> loadCages() async {
    final response = await _repository.getAllCages();
    cages = Future.value(response.data);
  }

  Future<String> fetchHlsUrl(String cameraId) async {
    final apiUrl = '/api/Cameras/$cameraId/live';
    final response =
        await ApiCaller.instance.request(path: apiUrl, method: ApiMethod.get);

    response.either((success) {
      return Api.baseApiUrl + apiUrl;
    }, (error) {
      // handle error
    });

    // return '';
    return Api.baseApiUrl + apiUrl;
  }
}
