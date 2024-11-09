import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/common/vma_toast.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/medicine_item.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/update_vaccination_stage_dialog.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/vaccination_stage_updated_event.dart';
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

  Set<String> selectedPigIds = <String>{};

  @override
  void initState() {
    super.initState();
    _stage = widget.vaccinationStage;
    _model.loadMedicines(_stage.id);
    VMAToast.init(context);
    EventManager.register<VaccinationStageUpdatedEvent>(_handleStageUpdated);
  }

  @override
  void dispose() {
    EventManager.unregister(VaccinationStageUpdatedEvent);
    super.dispose();
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

  void _showUpdateMedicineDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cập nhật giai đoạn tiêm phòng'),
          content: UpdateVaccinationStageDialog(
            stageId: _stage.id,
            selectPig: selectPig,
            deselectPig: deselectPig,
            isIdSelected: isIdSelected,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: _updateVaccinationStage,
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }

  void _handleStageUpdated(VaccinationStageUpdatedEvent event) {
    if (event.success) {
      VMAToast.showSuccess('updated');
    } else {
      VMAToast.showError('error occurred');
    }
    Navigator.of(context).pop();
  }

  void _updateVaccinationStage() {
    _model.updateVaccinationStage(selectedPigIds, widget.vaccinationStage.id);
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
        if (snapshot.data?.isEmpty ?? false) {
          return const Text('Không có thông tin về giai đoạn tiêm phòng này');
        }

        return SizedBox(
          height: 75 * medicines.length.toDouble() +
              15 /* space for UPDATE button */,
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (BuildContext context, int index) {
              final Medicine medicine = medicines[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MedicineItem(
                    name: medicine.medicineName,
                    quantity: medicine.quantity,
                    status: medicine.status,
                  ),
                  TextButton(
                    onPressed: _showUpdateMedicineDialog,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        Colors.white,
                      ),
                    ),
                    child: const Text('Cập nhật'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
