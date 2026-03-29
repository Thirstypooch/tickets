import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final _shortDate = DateFormat('MM/dd/yyyy');
  static final _mediumDate = DateFormat('MMM d, yyyy');
  static final _monthDay = DateFormat('MMM d');

  /// MM/dd/yyyy — used in booking widget date fields
  static String short(DateTime date) => _shortDate.format(date);

  /// MMM d, yyyy — used in review dates, trip dates
  static String medium(DateTime date) => _mediumDate.format(date);

  /// MMM d — compact date for cards
  static String monthDay(DateTime date) => _monthDay.format(date);

  /// "Jan 15 - Jan 18" range format
  static String range(DateTime start, DateTime end) =>
      '${monthDay(start)} - ${monthDay(end)}';
}
