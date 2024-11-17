import 'package:flutter/material.dart';

class MedicineStatusLabel extends StatelessWidget {
  final String status;

  const MedicineStatusLabel({super.key, required this.status});

  Color _getColor() {
    switch (status) {
      case "Chờ xử lý":
        return Colors.amber;
      case "Đã yêu cầu":
        return Colors.teal;
      case "Đã duyệt":
        return Colors.green;
      case "Từ chối":
      case "Đã hủy":
        return Colors.red;
      default:
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
          status,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
