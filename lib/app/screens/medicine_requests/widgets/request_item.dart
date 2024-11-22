import 'package:flutter/material.dart';
import 'package:vma/app/screens/medicine_requests/widgets/request_details.dart';
import 'package:vma/app/screens/medicine_requests/widgets/request_status.dart';
import 'package:vma/core/models/inventory_request.dart';
import 'package:vma/core/utils/date_time_helper.dart';
import 'package:vma/core/utils/string_helper.dart';

class RequestItem extends StatelessWidget {
  final InventoryRequest request;
  final BuildContext context;

  const RequestItem({super.key, required this.request, required this.context});

  void _showRequestDetails() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return RequestDetails(inventoryRequestId: request.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green.shade50,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: _showRequestDetails,
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
                            message: StringHelper.resolveNullableString(
                              request.title,
                              'Không có tiêu đề',
                            ),
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
