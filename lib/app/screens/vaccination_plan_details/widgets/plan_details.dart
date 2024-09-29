import 'package:flutter/material.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/key_value_info.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/vaccination_stages.dart';
import 'package:vma/core/models/vaccination_plan_details.dart';
import 'package:vma/core/utils/date_time_helper.dart';

class PlanDetails extends StatelessWidget {
  final VaccinationPlanDetails plan;
  const PlanDetails({super.key, required this.plan});

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
                content: plan.description,
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
                content: DateTimeHelper.getFormattedDate(plan.expectedEndDate),
              ),
              KeyValueInfo(
                label: 'Trạng thái',
                content: plan.status.name,
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
              VaccinationStages(vaccinationStages: plan.vaccinationStages),
            ],
          ),
        ),
      ),
    );
  }
}
