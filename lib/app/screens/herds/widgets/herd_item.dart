import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/core/models/herd.dart';

class HerdItem extends StatelessWidget {
  final Herd herd;

  const HerdItem({super.key, required this.herd});

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: widgetWidth * 0.25,
            child: Text(
              herd.code,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onSelected: (String value) {
              if (value == 'navigate to herd_detail_screen.dart') {
                // TODO: Navigate to herd_detail_screen.dart
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'navigate to herd_detail_screen.dart',
                  child: Text('Xem danh sách heo'),
                ),
                PopupMenuItem<String>(
                  value: 'navigate to herd_vaccination_plan_screen.dart',
                  child: Text('Xem kế hoạch tiêm phòng'),
                ),
              ];
            },
          ),
        ],
      ),
      subtitle: Text(
        'Mô tả: ${herd.description}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
