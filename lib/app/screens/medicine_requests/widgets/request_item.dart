import 'package:flutter/material.dart';
import 'package:vma/app/screens/medicine_requests/widgets/request_status.dart';
import 'package:vma/core/models/medicine_request.dart';

class RequestItem extends StatelessWidget {
  final MedicineRequest request;

  const RequestItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final widgetWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widgetWidth * 0.5,
                      child: Tooltip(
                        message: request.id,
                        child: Text(
                          request.id,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Text(
                      request.newMedicineName ?? 'Chưa xác định',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    RequestStatus(status: request.status),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
