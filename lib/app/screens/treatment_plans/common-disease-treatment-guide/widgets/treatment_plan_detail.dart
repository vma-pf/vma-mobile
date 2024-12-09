import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_stages.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/key_value_info.dart';
import 'package:vma/core/utils/date_time_helper.dart';
import 'package:vma/core/utils/string_helper.dart';
import 'package:vma/core/view_models/treatment_plan_detail_model.dart';
import 'package:vma/core/models/treatment_plan_detail.dart' as vma;

class TreatmentPlanDetail extends StatefulWidget {
  final String planId;
  const TreatmentPlanDetail({super.key, required this.planId});

  @override
  State<StatefulWidget> createState() => _TreatmentPlanDetailState();
}

class _TreatmentPlanDetailState extends VMAState<TreatmentPlanDetail> {
  final _model = TreatmentPlanDetailModel();

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
          'Chi tiết kế hoạch điều trị',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ScopedModel<TreatmentPlanDetailModel>(
        model: _model,
        child: ScopedModelDescendant<TreatmentPlanDetailModel>(
          builder: (
            BuildContext context,
            Widget? child,
            TreatmentPlanDetailModel model,
          ) {
            return FutureBuilder<vma.TreatmentPlanDetail?>(
              future: model.plan,
              builder: (
                BuildContext context,
                AsyncSnapshot<vma.TreatmentPlanDetail?> snapshot,
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
                final finalWidget = _buildPlanDetail(plan);

                return handleAsyncSnapshot(snapshot, finalWidget);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlanDetail(vma.TreatmentPlanDetail plan) {
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
                      label: 'Ngày kết thúc dự kiến',
                      content: DateTimeHelper.getFormattedDate(
                        plan.expectedTimePeriod,
                      ),
                    ),
                    KeyValueInfo(
                      label: 'Ngày kết thúc thực tế',
                      content:
                          DateTimeHelper.isDefaultDate(plan.actualTimePeriod)
                              ? 'Chưa có'
                              : DateTimeHelper.getFormattedDate(
                                  plan.actualTimePeriod,
                                ),
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
                      'Các giai đoạn điều trị',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TreatmentStages(
                      treatmentStages: plan.treatmentStages,
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
