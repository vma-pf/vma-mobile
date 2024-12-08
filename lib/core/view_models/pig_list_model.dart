import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/pig.dart';
import 'package:vma/core/repositories/pig_repository.dart';

class PigListModel extends Model {
  final _repository = PigRepository();

  // Search parameters
  String searchText = '';
  Set<String> selectedBreeds = {};
  Set<String> healthStatuses = {};
  double minWeight = 0;
  double minHeight = 0;
  double minWidth = 0;
  double maxWeight = 50;
  double maxHeight = 50;
  double maxWidth = 50;
  // Default values
  final double _defaultMinWeight = 0;
  final double _defaultMinHeight = 0;
  final double _defaultMinWidth = 0;
  final double _defaultMaxWeight = 50;
  final double _defaultMaxHeight = 50;
  final double _defaultMaxWidth = 50;

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

  Future<List<String>> _breeds = Future.value([]);
  Future<List<String>> get breeds => _breeds;
  set breeds(Future<List<String>> value) {
    _breeds = value;
    notifyListeners();
  }

  Future<void> loadPigs() async {
    final response = await _repository.getAllPigs(pageSize, pageIndex);
    pageSize = response.pageSize;
    pageIndex = response.pageIndex;
    pigs = Future.value(response.data);
  }

  Future<void> loadBreeds() async {
    breeds = _repository.getAllBreeds();
  }

  // TODO: all api to search
  Future<void> searchPigs() async {
    final codeQuery = 'pigCode($searchText)';
    final heightQuery =
        'height(${minHeight.toString()}-${maxHeight.toString()})';
    final weightQuery =
        'weight(${minWeight.toString()}-${maxWeight.toString()})';
    final widthQuery = 'width(${minWidth.toString()}-${maxWidth.toString()})';
    final breedQuery = 'breed(${selectedBreeds.join('-')})';
    final heathStatusQuery = 'healthStatus(${healthStatuses.join('-')})';
    final query = {
      'filter':
          '$codeQuery$heightQuery$weightQuery$widthQuery$breedQuery$heathStatusQuery',
    };
    final response = await _repository.searchPigs(query);
    pigs = Future.value(response.data);
  }

  void resetSearchParameters() {
    minWeight = _defaultMinWeight;
    minHeight = _defaultMinHeight;
    minWidth = _defaultMinWidth;
    maxWeight = _defaultMaxWeight;
    maxHeight = _defaultMaxHeight;
    maxWidth = _defaultMaxWidth;

    healthStatuses.clear();
    selectedBreeds.clear();
  }
}
