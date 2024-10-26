import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/medicine_requests/widgets/medicine_request_item.dart';
import 'package:vma/core/models/medicine_request.dart';
import 'package:vma/core/view_models/medicine_request_list_model.dart';

class RequestDetails extends StatefulWidget {
  final String inventoryRequestId;

  const RequestDetails({super.key, required this.inventoryRequestId});

  @override
  State<StatefulWidget> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends VMAState<RequestDetails> {
  final MedicineRequestListModel _model = MedicineRequestListModel();

  @override
  initState() {
    super.initState();
    _model.loadRequests(widget.inventoryRequestId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: ScopedModel(
          model: _model,
          child: ScopedModelDescendant<MedicineRequestListModel>(
            builder: (
              BuildContext context,
              Widget? child,
              MedicineRequestListModel model,
            ) {
              return FutureBuilder(
                future: model.medicineRequests,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final List<MedicineRequest>? medicineRequests =
                        snapshot.data;
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
                        return MedicineRequestItem(request: medicineRequest);
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
