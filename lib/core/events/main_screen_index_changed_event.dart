import 'package:vma/core/events/event_base.dart';

class MainScreenIndexChangedEvent extends EventBase {
  final int index;

  MainScreenIndexChangedEvent({required this.index});
}
