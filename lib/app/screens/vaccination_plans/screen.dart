import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/view_models/vaccination_plan_list_model.dart';

class VaccinationPlans extends StatefulWidget {
  const VaccinationPlans({super.key});

  @override
  State<VaccinationPlans> createState() => _VaccinationPlanState();
}

class _VaccinationPlanState extends VMAState<VaccinationPlans> {
  final _model = VaccinationPlanListModel();

  @override
  void initState() {
    super.initState();
    _model.loadVaccinationPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kế hoạch tiêm phòng'),
        ),
        body: ScopedModel<VaccinationPlanListModel>(
          model: _model,
          child: ScopedModelDescendant<VaccinationPlanListModel>(
              builder: (context, child, model) {
            return FutureBuilder(
              future: model.vaccinationPlans,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final plans = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      final plan = plans[index];
                      return ListTile(
                        title: Text(plan.title),
                        subtitle: Text(plan.description),
                        trailing: Text(plan.pigCount.toString()),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }),
        ));
  }
}
