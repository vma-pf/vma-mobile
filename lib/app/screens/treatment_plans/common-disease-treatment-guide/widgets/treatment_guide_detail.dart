import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/medicine_requests/widgets/medicine_request_item.dart';
import 'package:vma/core/models/medicine_request.dart';
import 'package:vma/core/models/treatment_guide.dart';
import 'package:vma/core/view_models/medicine_request_list_model.dart';
import 'package:vma/core/view_models/treatment_guide.dart';

class TreatmentGuideDetail extends StatefulWidget {
  final String id;

  const TreatmentGuideDetail({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _TreatmentGuideDetailState();
}

class _TreatmentGuideDetailState extends VMAState<TreatmentGuideDetail> {
  final TreatmentGuideModel _model = TreatmentGuideModel();

  @override
  initState() {
    super.initState();
    _model.loadDataById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: ScopedModel(
          model: _model,
          child: ScopedModelDescendant<TreatmentGuideModel>(
            builder: (
              BuildContext context,
              Widget? child,
              TreatmentGuideModel model,
            ) {
              return FutureBuilder(
                future: model.treatmentGuide,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final TreatmentGuide treatmentGuide = snapshot.data;
                    if (treatmentGuide == null) {
                      return const Center(
                        child: Text('Không tìm thấy thông tin'),
                      );
                    }
                    return Text(treatmentGuide.treatmentTitle ?? '');
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
