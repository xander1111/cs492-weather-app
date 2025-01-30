import 'package:intl/intl.dart';

String? convertTimestampToDayAndHour(String? timestamp) {
  if (timestamp == null){
    return null;
  }
  // Parse the timestamp string into a DateTime object
  DateTime dateTime = DateTime.parse(timestamp);

  DateTime today = DateTime.now();
  today = DateTime(today.year, today.month, today.day);  // Reset to midnight of today

  String dayOfWeek = DateTime(dateTime.year, dateTime.month, dateTime.day).isAtSameMomentAs(today) ? 'Today' : DateFormat('EEEE').format(dateTime);

  String hour = DateFormat('h a').format(dateTime); // 12-hour format with AM/PM

  return '$dayOfWeek, $hour';
}