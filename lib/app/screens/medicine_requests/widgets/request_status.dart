import 'package:flutter/material.dart';
import 'package:vma/core/constants/inventory_request_statuses.dart';

class RequestStatus extends StatelessWidget {
  final String status;

  const RequestStatus({super.key, required this.status});

  Color _getStatusColor(String status) {
    switch (status) {
      case InventoryRequestStatuses.approved:
        return Colors.green;
      case InventoryRequestStatuses.processed:
        return Colors.blue;
      case InventoryRequestStatuses.rejected:
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
