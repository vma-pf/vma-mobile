import 'package:flutter/material.dart';
import 'package:vma/app/screens/medicine_requests/widgets/request_status.dart';
import 'package:vma/core/models/inventory_request.dart';
import 'package:vma/core/utils/date_time_helper.dart';
import 'package:vma/core/utils/string_helper.dart';

class RequestItem extends StatelessWidget {
  final InventoryRequest request;

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
      child: InkWell(
        onTap: () {
          // TODO: Navigate to request detail screen or show a dialog
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widgetWidth * 0.7,
                          child: Tooltip(
                            message: request.title,
                            child: Text(
                              StringHelper.resolveNullableString(
                                request.title,
                                'Không có tiêu đề',
                              ),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          DateTimeHelper.getFormattedDateTime(
                            request.createdAt,
                          ),
                        ),
                        Text(
                          StringHelper.resolveNullableString(
                            request.title,
                            'Không có mô tả',
                          ),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  RequestStatus(status: request.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
