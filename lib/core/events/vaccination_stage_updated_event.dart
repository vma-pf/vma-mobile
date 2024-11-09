import 'package:vma/core/events/event_base.dart';

class VaccinationStageUpdatedEvent extends EventBase {
  final bool success;

  VaccinationStageUpdatedEvent({this.success = false});
}
