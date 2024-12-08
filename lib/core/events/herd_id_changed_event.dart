import 'package:vma/core/events/event_base.dart';

class HerdIdChangedEvent extends EventBase {
  final String herdId;

  HerdIdChangedEvent({required this.herdId});
}
