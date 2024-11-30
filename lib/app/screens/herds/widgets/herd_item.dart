import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/screens/pig_list/screen.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/main_screen_index_changed_event.dart';
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
            onSelected: (String route) {
              if (route == Routes.pigList) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PigList();
                    },
                  ),
                );
                return;
              } else if (route == Routes.vaccinationPlans) {
                Navigator.of(context).pop();
                final event = MainScreenIndexChangedEvent(index: 1);
                EventManager.fire(event);
                return;
              }
              // TODO: log error
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: Routes.pigList,
                  child: Text('Xem danh sách heo'),
                ),
                PopupMenuItem<String>(
                  value: Routes.vaccinationPlans,
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
