import 'package:flutter/material.dart';
import 'package:vma/core/models/enums/pig_status.dart';
import 'package:vma/core/models/pig_detail.dart';
import 'package:vma/core/utils/string_helper.dart';

class DetailInfo extends StatelessWidget {
  final PigDetail pigDetail;
  const DetailInfo({super.key, required this.pigDetail});

  Icon _getIconByGender() {
    if (pigDetail.gender.toLowerCase() == 'male') {
      return const Icon(Icons.male, color: Colors.blue);
    } else {
      return const Icon(Icons.female, color: Colors.pink);
    }
  }

  Color _getColorByStatus() {
    switch (pigDetail.status) {
      case PigStatus.alive:
        return Colors.green;
      case PigStatus.dead:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Chi tiết heo',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor)),
      Text(pigDetail.code,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w900, color: Colors.grey)),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Breed:'),
              Text(pigDetail.breed),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Gender:'),
              Row(children: [
                Text(pigDetail.gender),
                _getIconByGender(),
              ])
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Status:'),
              DecoratedBox(
                  decoration: BoxDecoration(
                      color: _getColorByStatus(),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      child: Text(
                          StringHelper.capitalize(pigDetail.status.name),
                          style: const TextStyle(color: Colors.white))))
            ]),
          ]))
    ]);
  }
}
