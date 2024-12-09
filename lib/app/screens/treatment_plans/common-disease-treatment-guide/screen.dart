import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/common_disease_list.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_guide_list.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_plan_list.dart';
import 'package:vma/core/view_models/common_disease_model.dart';

class CommonDiseaseAndTreatmentGuideScreen extends StatefulWidget {
  const CommonDiseaseAndTreatmentGuideScreen({super.key});

  @override
  State<CommonDiseaseAndTreatmentGuideScreen> createState() =>
      _CommonDiseaseAndTreatmentGuideScreenState();
}

class _CommonDiseaseAndTreatmentGuideScreenState
    extends VMAState<CommonDiseaseAndTreatmentGuideScreen> {
  final CommonDiseaseModel _model = CommonDiseaseModel();

  @override
  initState() {
    super.initState();
    _model.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin điều trị'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Điều trị',
              ),
              Tab(text: 'Kế hoạch điều trị'),
              Tab(text: 'Bệnh phổ biến'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              // child: Text("Thong tin dieu tri (Beta)"),
              child: TreatmentPlanList(),
            ),
            Center(
              child: TreatmentGuideList(),
            ),
            Center(
              child: CommonDiseaseList(),
            ),
          ],
        ),
      ),
    );
  }
}
