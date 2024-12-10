import 'package:flutter/material.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_plan_detail.dart';
import 'package:vma/app/screens/vaccination_plans/widgets/plan_status_label.dart';
import 'package:vma/core/models/treatment_plan.dart';
import 'package:vma/core/utils/string_helper.dart';

class TreatmentPlanItem extends StatelessWidget {
  final TreatmentPlan plan;
  const TreatmentPlanItem({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final double widgetWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(2, 2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widgetWidth * 0.55,
                          child: Text(
                            plan.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        PlanStatusLabel(
                          status: StringHelper.resolveNullableString(
                            plan.status,
                            'Không rõ',
                          ),
                        ),
                      ],
                    ),
                    Text(
                      StringHelper.resolveNullableString(
                        plan.description,
                        'Không có mô tả',
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TreatmentPlanDetail(planId: plan.id),
                    ),
                  );
                },
                icon: Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
