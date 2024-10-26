import 'package:scoped_model/scoped_model.dart';
import 'package:vma/core/models/inventory_request.dart';
import 'package:vma/core/repositories/inventory_request_repository.dart';

class MedicineRequestListModel extends Model {
  final InventoryRequestRepository _repository = InventoryRequestRepository();

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

  Future<List<InventoryRequest>> _medicineRequests = Future.value([]);
  Future<List<InventoryRequest>> get medicineRequests => _medicineRequests;
  set medicineRequests(Future<List<InventoryRequest>> value) {
    _medicineRequests = value;
    notifyListeners();
  }

  void loadRequests() async {
    final response =
        await _repository.getMyMedicineRequests(pageSize, pageIndex);
    pageSize = response.pageSize;
    pageIndex = response.pageIndex;
    medicineRequests = Future.value(response.data);
  }
}
