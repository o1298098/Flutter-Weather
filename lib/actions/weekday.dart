import 'package:intl/intl.dart';

class Weekday {
  static String getWeekdayString(int time) {
    var day = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat.EEEE().format(day);
  }
}
