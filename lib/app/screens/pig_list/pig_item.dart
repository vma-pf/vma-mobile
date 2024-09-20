import 'package:flutter/material.dart';
import 'package:vma/app/screens/pig_list/detail_info_text.dart';
import 'package:vma/app/screens/pig_list/status_label.dart';
import 'package:vma/core/models/pig.dart';

class PigItem extends StatelessWidget {
  final Pig pig;
  const PigItem({super.key, required this.pig});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pig.code,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(pig.cageCode,
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        title: Text(pig.breed),
        subtitle: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 5),
            shrinkWrap: true,
            children: [
              DetailInfoText(label: 'Cân nặng', data: pig.weight),
              DetailInfoText(label: 'Chiều cao', data: pig.height),
              DetailInfoText(label: 'Chiều rộng', data: pig.width),
            ]),
        trailing: StatusLabel(status: pig.healthStatus),
      ),
    );
  }
}
