import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_guide_item.dart';
import 'package:vma/core/models/treatment_guide.dart';
import 'package:vma/core/view_models/treatment_guide_model.dart';

class TreatmentGuideList extends StatefulWidget {
  const TreatmentGuideList({super.key});

  @override
  State<TreatmentGuideList> createState() => _TreatmentGuideListState();
}

class _TreatmentGuideListState extends VMAState<TreatmentGuideList> {
  final TreatmentGuideModel _model = TreatmentGuideModel();

  @override
  initState() {
    super.initState();
    _model.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<TreatmentGuideModel>(
        model: _model,
        child: ScopedModelDescendant<TreatmentGuideModel>(
          builder: (
            BuildContext context,
            Widget? child,
            TreatmentGuideModel model,
          ) {
            return FutureBuilder(
              future: model.treatmentGuides,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<TreatmentGuide>? treatmentGuides = snapshot.data;
                  if (treatmentGuides == null) {
                    return const Center(
                      child: Text('Không tìm thấy thông tin'),
                    );
                  }
                  return ListView.builder(
                    itemCount: treatmentGuides.length,
                    itemBuilder: (BuildContext context, int index) {
                      final TreatmentGuide treatmentGuide =
                          treatmentGuides[index];
                      return TreatmentGuideItem(
                        request: treatmentGuide,
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
