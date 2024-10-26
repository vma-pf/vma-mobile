import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getFormattedDate(DateTime dateTime) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  static String getFormattedDateTime(DateTime dateTime) {
    String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDateTime;
  }
}
