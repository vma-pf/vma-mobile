import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/models/medicine_request.dart';
import 'package:vma/core/view_models/medicine_request_list_model.dart';

class MedicineRequestsScreen extends StatefulWidget {
  const MedicineRequestsScreen({super.key});

  @override
  State<MedicineRequestsScreen> createState() => _MedicineRequestsScreenState();
}

class _MedicineRequestsScreenState extends VMAState<MedicineRequestsScreen> {
  final MedicineRequestListModel _model = MedicineRequestListModel();

  @override
  initState() {
    super.initState();
    _model.loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu cầu thuốc'),
      ),
      body: ScopedModel<MedicineRequestListModel>(
        model: _model,
        child: ScopedModelDescendant<MedicineRequestListModel>(
          builder: (BuildContext context, Widget? child,
              MedicineRequestListModel model) {
            return FutureBuilder(
              future: model.medicineRequests,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<MedicineRequest>? medicineRequests = snapshot.data;
                  if (medicineRequests == null) {
                    return const Center(
                      child: Text('Không tìm thấy thông tin'),
                    );
                  }
                  return ListView.builder(
                    itemCount: medicineRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MedicineRequest medicineRequest =
                          medicineRequests[index];
                      return ListTile(
                        title: Text(medicineRequest.id),
                        subtitle: Text(medicineRequest.newMedicineName),
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
