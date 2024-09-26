import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vma/app/common/vma_state.dart';

class DemoTimeline extends StatefulWidget {
  const DemoTimeline({super.key});

  @override
  State<DemoTimeline> createState() => _DemoTimelineState();
}

class _DemoTimelineState extends VMAState<DemoTimeline> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return TimelineTile(
          alignment: TimelineAlign.start,
          isFirst: index == 0,
          isLast: index == 2,
          indicatorStyle: IndicatorStyle(
            width: 20,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(left: 16),
          ),
          endChild: Container(
            constraints: const BoxConstraints(minHeight: 100),
            child: Text('Item $index'),
          ),
          beforeLineStyle: LineStyle(
            color: Theme.of(context).primaryColor,
            thickness: 6,
          ),
          afterLineStyle: LineStyle(
            color: Theme.of(context).primaryColor,
            thickness: 6,
          ),
        );
      },
    );
  }
}
