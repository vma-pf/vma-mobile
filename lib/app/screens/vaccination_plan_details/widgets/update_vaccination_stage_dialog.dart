import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/pig_vaccination_item.dart';
import 'package:vma/core/models/pig_vaccination_stage_for_stage_detail.dart';
import 'package:vma/core/view_models/update_vaccination_stage_model.dart';

class UpdateVaccinationStageDialog extends StatefulWidget {
  final String stageId;
  final bool Function(String) isIdSelected;
  final Function(String) selectPig;
  final Function(String) deselectPig;
  const UpdateVaccinationStageDialog({
    super.key,
    required this.stageId,
    required this.isIdSelected,
    required this.selectPig,
    required this.deselectPig,
  });

  @override
  State<StatefulWidget> createState() => _UpdateVaccinationStageDialogState();
}

class _UpdateVaccinationStageDialogState
    extends State<UpdateVaccinationStageDialog> {
  final UpdateVaccinationStageModel _model = UpdateVaccinationStageModel();

  void _handleCheckboxChanged(bool? value, String pigId) {
    setState(() {
      if (value ?? false) {
        widget.selectPig(pigId);
      } else {
        widget.deselectPig(pigId);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _model.loadVaccinationStage(widget.stageId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UpdateVaccinationStageModel>(
      model: _model,
      child: ScopedModelDescendant<UpdateVaccinationStageModel>(
        builder: (context, child, model) {
          return FutureBuilder<List<PigVaccinationStageForStageDetail>>(
            future: _model.stages,
            builder: (
              BuildContext futureBuildContext,
              AsyncSnapshot<List<PigVaccinationStageForStageDetail>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final List<PigVaccinationStageForStageDetail> stages =
                    snapshot.data ?? [];

                return SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: stages.length,
                    itemBuilder: (BuildContext listviewContext, int index) {
                      final PigVaccinationStageForStageDetail item =
                          stages[index];
                      return PigVaccinationItem(
                        isCheked: widget.isIdSelected(item.pig.id),
                        onChanged: (value) =>
                            _handleCheckboxChanged(value, item.pig.id),
                        pigCode: item.pig.pigCode,
                      );
                    },
                  ),
                );
              } else {
                return const Text('Something went wrong');
              }
            },
          );
        },
      ),
    );
  }
}
