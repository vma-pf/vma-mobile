import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vma/app/screens/pig_list/screen.dart';
import 'package:vma/core/constants/routes.dart';
import 'package:vma/core/events/event_manager.dart';
import 'package:vma/core/events/herd_id_changed_event.dart';
import 'package:vma/core/events/main_screen_index_changed_event.dart';
import 'package:vma/core/models/herd.dart';

class HerdItem extends StatelessWidget {
  final Herd herd;

  const HerdItem({super.key, required this.herd});

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryFixed,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: widgetWidth * 0.25,
              child: Text(
                herd.code.toUpperCase(),
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
                        return PigList(herdId: herd.id);
                      },
                    ),
                  );
                  return;
                } else if (route == Routes.vaccinationPlans) {
                  Navigator.of(context).pop();
                  final screenIndexChangedEvent =
                      MainScreenIndexChangedEvent(index: 1);
                  final herdIdChangedEvent =
                      HerdIdChangedEvent(herdId: herd.id);
                  EventManager.fire(screenIndexChangedEvent);
                  EventManager.fire(herdIdChangedEvent);
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextInfo('Giống heo', herd.breed),
            _buildTextInfo('Trạng thái', herd.status),
            _buildTextInfo('Số lượng', herd.totalNumber.toString()),
            _buildTextInfo(
              'Cân nặng trung bình',
              '${herd.averageWeight.toString()} kg',
            ),
            Text(
              'Mô tả: ${herd.description}',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextInfo(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('$label: '),
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold),
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
