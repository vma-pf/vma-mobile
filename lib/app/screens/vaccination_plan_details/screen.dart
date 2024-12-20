import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/plan_details.dart';
import 'package:vma/core/models/vaccination_plan_details.dart';
import 'package:vma/core/view_models/vaccination_plan_details_model.dart';

class VaccinationPlanDetailsScreen extends StatefulWidget {
  final String planId;

  const VaccinationPlanDetailsScreen({super.key, required this.planId});

  @override
  State<VaccinationPlanDetailsScreen> createState() =>
      _VaccinationPlanDetailsState();
}

class _VaccinationPlanDetailsState
    extends VMAState<VaccinationPlanDetailsScreen> {
  final VaccinationPlanDetailsModel _model = VaccinationPlanDetailsModel();

  @override
  void initState() {
    super.initState();
    _model.loadPlan(widget.planId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết kế hoạch tiêm phòng',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ScopedModel<VaccinationPlanDetailsModel>(
        model: _model,
        child: ScopedModelDescendant<VaccinationPlanDetailsModel>(
          builder: (
            BuildContext context,
            Widget? child,
            VaccinationPlanDetailsModel model,
          ) {
            return FutureBuilder<VaccinationPlanDetails?>(
              future: model.plan,
              builder: (
                BuildContext context,
                AsyncSnapshot<VaccinationPlanDetails?> snapshot,
              ) {
                final plan = snapshot.data;
                if (plan == null) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Đã xảy ra lỗi: ${snapshot.error}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final finalWidget = PlanDetails(plan: plan);

                return handleAsyncSnapshot(snapshot, finalWidget);
              },
            );
          },
        ),
      ),
    );
  }
}
