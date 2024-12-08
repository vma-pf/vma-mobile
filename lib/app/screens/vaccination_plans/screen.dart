import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/vaccination_plans/widgets/vaccination_plan_item.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/herd_id_changed_event.dart';
import 'package:vma/core/view_models/vaccination_plan_list_model.dart';

class VaccinationPlans extends StatefulWidget {
  final String herdId;
  const VaccinationPlans({super.key, required this.herdId});

  @override
  State<VaccinationPlans> createState() => _VaccinationPlanState();
}

class _VaccinationPlanState extends VMAState<VaccinationPlans> {
  final _model = VaccinationPlanListModel();

  @override
  void initState() {
    super.initState();
    _model.loadVaccinationPlans(widget.herdId);
  }

  @override
  void dispose() {
    final event = HerdIdChangedEvent(herdId: '');
    EventManager.fire(event);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<VaccinationPlanListModel>(
        model: _model,
        child: ScopedModelDescendant<VaccinationPlanListModel>(
          builder: (BuildContext scopeContext, child, model) {
            return FutureBuilder(
              future: model.vaccinationPlans,
              builder: (BuildContext futureBuildContext, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final plans = snapshot.data ?? [];

                  if (plans.isEmpty) {
                    return const Center(
                      child: Text('Không có kế hoạch tiêm phòng'),
                    );
                  }

                  return ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (BuildContext listViewContext, index) {
                      final plan = plans[index];
                      return VaccinationPlanItem(plan: plan);
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
