import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/constants/medicine_request_statuses.dart';
import 'package:vma/core/models/medicine_request.dart';
import 'package:vma/core/utils/string_helper.dart';

class MedicineRequestItem extends StatefulWidget {
  final MedicineRequest request;

  const MedicineRequestItem({super.key, required this.request});

  @override
  State<StatefulWidget> createState() => _MedicineRequestItemState();
}

class _MedicineRequestItemState extends VMAState<MedicineRequestItem> {
  Color _getStatusColor() {
    final status = widget.request.status;
    switch (status) {
      case MedicineRequestStatuses.pending:
        return Colors.orange;
      case MedicineRequestStatuses.accepted:
        return Colors.green;
      case MedicineRequestStatuses.rejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildNewMedicineLabel() {
    if (widget.request.isPurchaseNeeded) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _getStatusColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Thuốc cần nhập',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  String _getMedicineName() {
    String? result = widget.request.medicineName;
    if (result.isEmpty) {
      result = widget.request.newMedicineName;
    }

    return StringHelper.resolveNullableString(result, 'Không có tên thuốc');
  }

  @override
  Widget build(BuildContext context) {
    final double widgetWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: widgetWidth * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tên thuốc: ${_getMedicineName()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Số lượng: ${widget.request.quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: 'Trạng thái: ',
                    children: [
                      TextSpan(
                        text: widget.request.status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(),
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          _buildNewMedicineLabel(),
        ],
      ),
    );
  }
}
