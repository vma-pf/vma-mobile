import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/medicine_requests/widgets/request_item.dart';
import 'package:vma/core/models/inventory_request.dart';
import 'package:vma/core/view_models/inventory_request_list_model.dart';

class MedicineRequestsScreen extends StatefulWidget {
  const MedicineRequestsScreen({super.key});

  @override
  State<MedicineRequestsScreen> createState() => _MedicineRequestsScreenState();
}

class _MedicineRequestsScreenState extends VMAState<MedicineRequestsScreen> {
  final InventoryRequestListModel _model = InventoryRequestListModel();

  @override
  initState() {
    super.initState();
    _model.loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Yêu cầu xuất thuốc'),
      ),
      body: ScopedModel<InventoryRequestListModel>(
        model: _model,
        child: ScopedModelDescendant<InventoryRequestListModel>(
          builder: (
            BuildContext context,
            Widget? child,
            InventoryRequestListModel model,
          ) {
            return FutureBuilder(
              future: model.medicineRequests,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<InventoryRequest>? medicineRequests =
                      snapshot.data;
                  if (medicineRequests == null) {
                    return const Center(
                      child: Text('Không tìm thấy thông tin'),
                    );
                  }
                  return ListView.builder(
                    itemCount: medicineRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      final InventoryRequest medicineRequest =
                          medicineRequests[index];
                      return RequestItem(
                        request: medicineRequest,
                        context: context,
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
