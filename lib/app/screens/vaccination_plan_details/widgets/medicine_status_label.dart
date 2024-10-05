import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/core/models/enums/medicine_status.dart';
import 'package:vma/core/utils/medicine_status_transformer.dart';

class MedicineStatusLabel extends StatelessWidget {
  final MedicineStatus status;

  const MedicineStatusLabel({super.key, required this.status});

  Color _getColor() {
    switch (status) {
      case MedicineStatus.pending:
        return Colors.amber;
      case MedicineStatus.requested:
        return Colors.teal;
      case MedicineStatus.approved:
        return Colors.green;
      case MedicineStatus.rejected:
        return Colors.red;
      case MedicineStatus.unknown:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Text(
          MedicineStatusTransformer.tranformToText(status),
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
