import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/models/medicine.dart';
import 'package:vma/core/models/vaccination_stage.dart';
import 'package:vma/core/view_models/vaccination_stage_details_model.dart';

class VaccinationStageDetail extends StatefulWidget {
  final VaccinationStage vaccinationStage;

  const VaccinationStageDetail({super.key, required this.vaccinationStage});

  @override
  State<StatefulWidget> createState() => VaccinationStageDetailState();
}

class VaccinationStageDetailState extends VMAState<VaccinationStageDetail> {
  late final VaccinationStage _stage;
  final _model = VaccinationStageDetailsModel();

  @override
  void initState() {
    super.initState();
    _stage = widget.vaccinationStage;
    _model.loadMedicines(_stage.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Medicine>>(
      future: _model.medicines,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Medicine>> snapshot,
      ) {
        final medicines = snapshot.data;
        if (medicines == null) {
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
        return SizedBox(
          height: 75 * medicines.length.toDouble(),
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (BuildContext context, int index) {
              final medicine = medicines[index];
              return ListTile(
                title: Text(medicine.id),
                subtitle: Text(medicine.medicineName),
              );
            },
          ),
        );
      },
    );
  }
}
