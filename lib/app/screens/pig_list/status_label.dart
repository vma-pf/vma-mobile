import 'package:flutter/material.dart';
import 'package:vma/core/models/enums/pig_health_status.dart';
import 'package:vma/core/utils/string_helper.dart';

class StatusLabel extends StatelessWidget {
  final PigHealthStatus status;
  const StatusLabel({super.key, required this.status});

  Color _getColorByStatus() {
    switch (status) {
      case PigHealthStatus.normal:
        return Colors.green;
      case PigHealthStatus.sick:
        return Colors.red;
      case PigHealthStatus.unknown:
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _getColorByStatus(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        StringHelper.capitalize(status.name),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
