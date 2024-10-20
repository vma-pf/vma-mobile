import 'package:flutter/material.dart';
import 'package:vma/app/screens/pig_detail/screen.dart';
import 'package:vma/app/screens/pig_list/widgets/detail_info_text.dart';
import 'package:vma/app/screens/pig_list/widgets/status_label.dart';
import 'package:vma/core/models/pig.dart';

class PigItem extends StatelessWidget {
  final Pig pig;
  const PigItem({super.key, required this.pig});

  void _navigateToPigDetail(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => PigDetail(pigId: pig.id)));
  }

  @override
  Widget build(BuildContext context) {
    final widgetWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => _navigateToPigDetail(context),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                          message: pig.pigCode,
                          child: Text(
                            pig.pigCode,
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
                        pig.cageCode ?? 'Chưa xác định',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  StatusLabel(status: pig.healthStatus),
                ],
              ),
              const SizedBox(height: 10),
              GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // grid with 2 columns, each has height of 20px
                  childAspectRatio: widgetWidth / (2 * 20),
                ),
                shrinkWrap: true,
                children: [
                  DetailInfoText(label: 'Giống', data: pig.breed),
                  DetailInfoText(label: 'Cân nặng', data: '${pig.weight} kg'),
                  DetailInfoText(
                    label: 'Chiều cao',
                    data: '${pig.height} cm',
                  ),
                  DetailInfoText(
                    label: 'Chiều rộng',
                    data: '${pig.width} cm',
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
