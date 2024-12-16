import 'package:vma/core/models/enums/pig_health_status.dart';

class PigHealthStatusTransformer {
  static String tranformToText(PigHealthStatus status) {
    switch (status) {
      case PigHealthStatus.normal:
        return 'Bình thường';
      case PigHealthStatus.sick:
        return 'Bệnh';
      case PigHealthStatus.unknown:
        return '';
    }
  }
}
