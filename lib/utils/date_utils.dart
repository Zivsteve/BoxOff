import 'package:intl/intl.dart';

const String DEFAULT_FORMAT = 'MMM dd, yyyy';

String today() {
  return DateTime.now().toString();
}

String formatDate([String date, format = DEFAULT_FORMAT]) {
  return formatDateTime(DateTime.parse(date ?? today()), format);
}

String formatTimestamp(int ms, [format = DEFAULT_FORMAT]) {
  return formatDateTime(DateTime.fromMillisecondsSinceEpoch(ms * 1000), format);
}

String formatDateTime(DateTime dt, [format = DEFAULT_FORMAT]) {
  return DateFormat(format).format(dt);
}

String getReadableDuration(int minutes) {
  final d = Duration(minutes: minutes);
  return "${d.inHours.remainder(60)} hr ${d.inMinutes.remainder(60)} min";
}

Duration getDateSince(String date) {
  return DateTime.now().difference(DateTime.parse(date));
}

int getYearsSince(String date) {
  return (getDateSince(date).inDays / 365).floor();
}
