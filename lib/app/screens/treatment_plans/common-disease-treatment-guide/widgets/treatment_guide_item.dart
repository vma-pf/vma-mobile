import 'package:flutter/material.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_guide_detail.dart';
import 'package:vma/core/models/treatment_guide.dart';
import 'package:vma/core/utils/string_helper.dart';

class TreatmentGuideItem extends StatelessWidget {
  final TreatmentGuide request;
  final BuildContext context;

  const TreatmentGuideItem({
    super.key,
    required this.request,
    required this.context,
  });

  void _showRequestDetails() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TreatmentGuideDetail(id: request.id);
      },
    );
  }

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
                            message: request.treatmentTitle,
                            child: Text(
                              StringHelper.resolveNullableString(
                                request.treatmentTitle,
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
                          StringHelper.resolveNullableString(
                            request.authorName,
                            'Không có tên',
                          ),
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          StringHelper.resolveNullableString(
                            request.treatmentDescription,
                            'Không có mô tả',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
