import 'package:flutter/cupertino.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/models/vaccination_stage.dart';

class VaccinationStageDetail extends StatefulWidget {
  final VaccinationStage vaccinationStage;

  const VaccinationStageDetail({super.key, required this.vaccinationStage});

  @override
  State<StatefulWidget> createState() => VaccinationStageDetailState();
}

class VaccinationStageDetailState extends VMAState<VaccinationStageDetail> {
  late final VaccinationStage stage;

  @override
  void initState() {
    super.initState();
    stage = widget.vaccinationStage;
  }

  @override
  Widget build(BuildContext context) {
    return const Text('something');
  }
}
