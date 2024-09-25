import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getFormattedDate(DateTime dateTime) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
