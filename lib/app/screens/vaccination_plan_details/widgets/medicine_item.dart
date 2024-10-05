import 'package:flutter/cupertino.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/medicine_status_label.dart';
import 'package:vma/core/models/enums/medicine_status.dart';

class MedicineItem extends StatelessWidget {
  final String name;
  final int quantity;
  final MedicineStatus status;

  const MedicineItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final widgetWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widgetWidth * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text('Số lượng: ${quantity.toString()}'),
            ],
          ),
        ),
        MedicineStatusLabel(status: status),
      ],
    );
  }
}
