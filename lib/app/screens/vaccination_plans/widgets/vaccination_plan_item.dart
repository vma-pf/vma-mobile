import 'package:flutter/material.dart';
import 'package:vma/app/screens/vaccination_plans/widgets/plan_progress.dart';
import 'package:vma/core/models/vaccination_plan.dart';

class VaccinationPlanItem extends StatelessWidget {
  final VaccinationPlan plan;

  const VaccinationPlanItem({
    super.key,
    required this.plan,
  });

  double _calculateProgress() {
    final startDate = plan.startDate;
    final endDate = plan.endDate;
    final now = DateTime.now();
    if (startDate.isAfter(endDate)) return 0;
    if (now.isBefore(startDate)) return 0;
    if (now.isAfter(endDate)) return 1;
    final totalDays = endDate.difference(startDate).inDays;
    final passedDays = now.difference(startDate).inDays;
    final percentage = passedDays / totalDays;

    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  plan.description,
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.date_range, size: 24),
                    const SizedBox(width: 10),
                    PlanProgress(
                      text: 'Progress',
                      percentage: _calculateProgress(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(context).primaryColor,
            ),
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
