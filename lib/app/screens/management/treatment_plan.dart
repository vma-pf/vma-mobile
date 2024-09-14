import 'package:flutter/material.dart';

class TreatmentPlan extends StatefulWidget {
  const TreatmentPlan({super.key});

  @override
  State<TreatmentPlan> createState() => _TreatmentPlanState();
}

class _TreatmentPlanState extends State<TreatmentPlan> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Treatment Plan"),
    );
  }
}
