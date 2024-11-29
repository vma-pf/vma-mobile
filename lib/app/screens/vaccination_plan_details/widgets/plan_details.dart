import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/common/vma_toast.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/key_value_info.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/vaccination_stages.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/medicines_requested_event.dart';
import 'package:vma/core/events/vaccination_stage_updated_event.dart';
import 'package:vma/core/models/vaccination_plan_details.dart';
import 'package:vma/core/utils/date_time_helper.dart';
import 'package:vma/core/utils/string_helper.dart';

class PlanDetails extends StatefulWidget {
  final VaccinationPlanDetails plan;
  const PlanDetails({super.key, required this.plan});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _PlanDetailsState(plan: plan);
}

class _PlanDetailsState extends VMAState<PlanDetails> {
  final VaccinationPlanDetails plan;
  _PlanDetailsState({required this.plan});

  @override
  void initState() {
    super.initState();
    VMAToast.init(context);
    EventManager.register<VaccinationStageUpdatedEvent>(_handleStageUpdated);
    EventManager.register<MedicinesRequestedEvent>(_handleMedicinesRequested);
  }

  @override
  void dispose() {
    EventManager.unregister(VaccinationStageUpdatedEvent);
    EventManager.unregister(MedicinesRequestedEvent);
    super.dispose();
  }

  void _handleStageUpdated(VaccinationStageUpdatedEvent event) {
    Navigator.of(context).pop();
    if (event.success) {
      VMAToast.showSuccess('Cập nhật giai đoạn tiêm phòng thành công');
    } else {
      VMAToast.showError('Đã có lỗi xảy ra');
    }
  }

  void _handleMedicinesRequested(MedicinesRequestedEvent event) {
    Navigator.of(context).pop();
    if (event.success) {
      VMAToast.showSuccess('Đã yêu cầu xuất thuốc thành công');
    } else {
      VMAToast.showError('Đã có lỗi xảy ra');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(3, 3),
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        plan.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    KeyValueInfo(
                      label: 'Mô tả',
                      content: StringHelper.resolveNullableString(
                        plan.description,
                        'Không có mô tả',
                      ),
                    ),
                    KeyValueInfo(
                      label: 'Ghi chú',
                      content: plan.note,
                    ),
                    KeyValueInfo(
                      label: 'Ngày bắt đầu',
                      content: DateTimeHelper.getFormattedDate(plan.startDate),
                    ),
                    KeyValueInfo(
                      label: 'Ngày kết thúc dự kiến',
                      content:
                          DateTimeHelper.getFormattedDate(plan.expectedEndDate),
                    ),
                    KeyValueInfo(
                      label: 'Trạng thái',
                      content: StringHelper.resolveNullableString(
                        plan.status,
                        'Không rõ',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Các giai đoạn tiêm phòng',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    VaccinationStages(
                      vaccinationStages: plan.vaccinationStages,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
