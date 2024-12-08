import 'package:flutter/material.dart';
import 'package:vma/core/constants/pig_health_statuses.dart';
import 'package:vma/core/utils/string_helper.dart';

class StatusLabel extends StatelessWidget {
  final String status;
  const StatusLabel({super.key, required this.status});

  Color _getColorByStatus() {
    switch (status) {
      case PigHealthStatuses.normal:
        return Colors.green;
      case PigHealthStatuses.sick:
        return Colors.red;
      // case PigHealthStatus.unknown:
      //   return Colors.black;
      default:
        return Colors.orange;
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
        StringHelper.capitalize(status),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
