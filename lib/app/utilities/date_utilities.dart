class DateUtilities {

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
  }

  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);
  }

  static DateTime nextDay(DateTime date) {
    return endOfDay(date).add(Duration(microseconds: 1));
  }

  static DateTime previousDay(DateTime date) {
    return startOfDay(date).subtract(Duration(days: 1));
  }

  static DateTime startOfWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0, 0, 0);
  }

  static DateTime endOfWeek(DateTime date) {
    final endOfWeek = date.add(Duration(days: 7 - date.weekday));
    return DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59, 999, 999);
  }

  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1, 0, 0, 0, 0, 0);
  }

  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month+1, 0, 23, 59, 59, 999, 999);
  }

  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1, 0, 0, 0, 0, 0);
  }

  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59, 999, 999);
  }

  static bool isBetween(DateTime date, DateTime start, DateTime end) {
    return  (date.millisecondsSinceEpoch >= start.millisecondsSinceEpoch && date.millisecondsSinceEpoch <= end.millisecondsSinceEpoch);
  }
}