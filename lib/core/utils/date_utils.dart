class AppDateUtils {
  static String getWeekdayName(String date) {
    final d = DateTime.parse(date);
    return [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ][d.weekday - 1];
  }

  static String getWeekdayShort(String date) {
    final d = DateTime.parse(date);
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d.weekday - 1];
  }
}
