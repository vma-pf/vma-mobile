import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_plan_item.dart';
import 'package:vma/core/view_models/treatment_plan_list_model.dart';

class TreatmentPlanList extends StatefulWidget {
  const TreatmentPlanList({super.key});

  @override
  State<StatefulWidget> createState() => _TreatmentPlanListState();
}

class _TreatmentPlanListState extends VMAState<TreatmentPlanList> {
  final _model = TreatmentPlanListModel();

  @override
  void initState() {
    super.initState();
    _model.loadTreatmentPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<TreatmentPlanListModel>(
        model: _model,
        child: ScopedModelDescendant<TreatmentPlanListModel>(
          builder: (BuildContext scopeContext, child, model) {
            return FutureBuilder(
              future: model.treatmentPlans,
              builder: (BuildContext futureBuildContext, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final plans = snapshot.data ?? [];

                  if (plans.isEmpty) {
                    return const Center(
                      child: Text('Không có kế hoạch điều trị'),
                    );
                  }

                  return ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (BuildContext listViewContext, index) {
                      final plan = plans[index];
                      return TreatmentPlanItem(plan: plan);
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
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
