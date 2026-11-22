import 'package:flutter_test/flutter_test.dart';
import 'package:woas/app/models/activity.dart';
import 'package:woas/app/utilities/date_utilities.dart';
import 'package:woas/app/widgets/chart_tile.dart';

void main() {
  group('DateUtilities.berlinDate', () {
    test('winter (CET, UTC+1): 23:30 UTC belongs to the next day', () {
      expect(DateUtilities.berlinDate(DateTime.utc(2026, 1, 15, 23, 30)), DateTime(2026, 1, 16));
      expect(DateUtilities.berlinDate(DateTime.utc(2026, 1, 15, 22, 59)), DateTime(2026, 1, 15));
    });

    test('summer (CEST, UTC+2): 22:30 UTC belongs to the next day', () {
      expect(DateUtilities.berlinDate(DateTime.utc(2026, 7, 15, 22, 30)), DateTime(2026, 7, 16));
      expect(DateUtilities.berlinDate(DateTime.utc(2026, 7, 15, 21, 59)), DateTime(2026, 7, 15));
    });

    test('DST switches at 01:00 UTC on the last Sunday of March / October', () {
      // 2026-03-29 and 2026-10-25 are the last Sundays.
      expect(DateUtilities.berlinOffset(DateTime.utc(2026, 3, 29, 0, 59)), Duration(hours: 1));
      expect(DateUtilities.berlinOffset(DateTime.utc(2026, 3, 29, 1, 0)), Duration(hours: 2));
      expect(DateUtilities.berlinOffset(DateTime.utc(2026, 10, 25, 0, 59)), Duration(hours: 2));
      expect(DateUtilities.berlinOffset(DateTime.utc(2026, 10, 25, 1, 0)), Duration(hours: 1));
    });
  });

  group('ChartTile.dailyTotals', () {
    final days = [DateTime(2026, 7, 14), DateTime(2026, 7, 15), DateTime(2026, 7, 16)];
    final activities = [
      Activity(time: DateTime.utc(2026, 7, 15, 6), distance: 5.0, duration: 30),
      Activity(time: DateTime.utc(2026, 7, 15, 17), distance: 2.5, duration: 15),
      // 22:30 UTC in summer = 00:30 CEST on the 16th
      Activity(time: DateTime.utc(2026, 7, 15, 22, 30), distance: 1.0, duration: 10),
      // same day-of-month, different month: must not be counted
      Activity(time: DateTime.utc(2026, 6, 15, 10), distance: 99.0, duration: 99),
      Activity(time: DateTime.utc(2026, 7, 14, 10)),
    ];

    test('sums distances of all entries per day', () {
      expect(ChartTile.dailyTotals(activities, days, ChartMetric.distance), [0.0, 7.5, 1.0]);
    });

    test('sums durations of all entries per day', () {
      expect(ChartTile.dailyTotals(activities, days, ChartMetric.duration), [0.0, 45.0, 10.0]);
    });
  });
}
