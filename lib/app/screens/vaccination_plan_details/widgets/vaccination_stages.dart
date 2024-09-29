import 'package:flutter/cupertino.dart';
import 'package:vma/core/models/vaccination_stage.dart';

class VaccinationStages extends StatelessWidget {
  final List<VaccinationStage> vaccinationStages;
  const VaccinationStages({super.key, required this.vaccinationStages});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('something'),
      Text('something'),
      Text('something'),
      Text('something'),
    ]);
  }
}
