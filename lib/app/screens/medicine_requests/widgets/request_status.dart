import 'package:flutter/material.dart';
import 'package:vma/core/constants/inventory_request_statuses.dart';

class RequestStatus extends StatelessWidget {
  final String status;

  const RequestStatus({super.key, required this.status});

  Color _getStatusColor(String status) {
    switch (status) {
      case InventoryRequestStatuses.processed:
        return Colors.green;
      case 'Đã hủy':
        return Colors.red;
      case InventoryRequestStatuses.pending:
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(
        color: _getStatusColor(status),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
