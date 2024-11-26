import 'package:vma/core/events/event_base.dart';

class MedicinesRequestedEvent extends EventBase {
  final bool success;

  MedicinesRequestedEvent({required this.success});
}
