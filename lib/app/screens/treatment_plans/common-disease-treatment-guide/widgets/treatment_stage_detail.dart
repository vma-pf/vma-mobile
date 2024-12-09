import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/models/treatment_stage.dart';
import 'package:vma/core/models/treatment_todo.dart';
import 'package:vma/core/view_models/treatment_stage_details_model.dart';

class TreatmentStageDetail extends StatefulWidget {
  final TreatmentStage treatmentStage;
  const TreatmentStageDetail({super.key, required this.treatmentStage});

  @override
  State<StatefulWidget> createState() => _TreatmentStageDetailState();
}

class _TreatmentStageDetailState extends VMAState<TreatmentStageDetail> {
  late final TreatmentStage _stage;
  final _model = TreatmentStageDetailsModel();

  Set<String> selectedPigIds = <String>{};

  @override
  void initState() {
    super.initState();
    _stage = widget.treatmentStage;
  }

  void selectPig(String pigId) {
    selectedPigIds.add(pigId);
  }

  void deselectPig(String pigId) {
    selectedPigIds.remove(pigId);
  }

  bool isIdSelected(String pigId) {
    return selectedPigIds.contains(pigId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TreatmentStageDetailsModel>(
      model: _model,
      child: ScopedModelDescendant<TreatmentStageDetailsModel>(
        builder: (
          BuildContext context,
          Widget? child,
          TreatmentStageDetailsModel model,
        ) {
          return _buildContent();
        },
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _stage.treatmentTodos.length,
              itemBuilder: (BuildContext context, int index) {
                final TreatmentTodo todo = _stage.treatmentTodos[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text(
                        'Bước ${index + 1}:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(todo.description),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
