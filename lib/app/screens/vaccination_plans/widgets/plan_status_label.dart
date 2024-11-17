import 'package:flutter/material.dart';

class PlanStatusLabel extends StatelessWidget {
  final String status;

  const PlanStatusLabel({super.key, required this.status});

  Color _getColor() {
    switch (status) {
      case "Đang thực hiện":
        return Colors.blue;
      case "Đã hoàn thành":
        return Colors.green;
      case "Đã hủy":
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
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
