import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/screens/pig_list/widgets/detail_info_text.dart';
import 'package:vma/app/screens/pig_list/widgets/status_label.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/models/pig.dart';

class PigItem extends StatelessWidget {
  final Pig pig;
  const PigItem({super.key, required this.pig});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => context.go(Routes.pigDetail, extra: pig.id),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pig.pigCode,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                pig.cageCode ?? 'Chưa xác định',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          title: Text(pig.breed),
          subtitle: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
            ),
            shrinkWrap: true,
            children: [
              DetailInfoText(label: 'Cân nặng', data: pig.weight),
              DetailInfoText(label: 'Chiều cao', data: pig.height),
              DetailInfoText(label: 'Chiều rộng', data: pig.width),
            ],
          ),
          trailing: StatusLabel(status: pig.healthStatus),
        ),
      ),
    );
  }
}
