import 'package:intl/intl.dart';

class DateUtils {
  static String getDayName(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('EEEE');
    return formatter.format(date);
  }
}
