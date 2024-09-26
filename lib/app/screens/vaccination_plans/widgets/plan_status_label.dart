import 'package:flutter/material.dart';
import 'package:vma/core/models/enums/vaccination_plan_status.dart';
import 'package:vma/core/utils/vaccination_plan_status_tranformer.dart';

class PlanStatusLabel extends StatelessWidget {
  final VaccinationPlanStatus status;

  const PlanStatusLabel({super.key, required this.status});

  Color _getColor() {
    switch (status) {
      case VaccinationPlanStatus.onGoing:
        return Colors.blue;
      case VaccinationPlanStatus.completed:
        return Colors.green;
      case VaccinationPlanStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        VaccinationPlanStatusTranformer.transformToText(status),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
