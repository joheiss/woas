import '../models/activity.dart';
import '../models/reporting_config.dart';
import '../models/reporting_interval.dart';
import '../utilities/date_utilities.dart';

class ReportingService {

  ReportingConfig buildIntervals(List<Activity> allActivities) {
    List<ReportingInterval> intervals = [];
    DateTime start;
    DateTime end;
    final today = DateTime.now();

    // today
    start = DateUtilities.startOfDay(today);
    end = DateUtilities.endOfDay(today);
    intervals.add(_buildInterval('Heute', allActivities, start, end));
    // last 3 days
    start = DateUtilities.startOfDay(today.subtract(Duration(days: 3)));
    end = DateUtilities.endOfDay(DateUtilities.previousDay(today));
    intervals.add(_buildInterval('3 Tage', allActivities, start, end));
    // last 10 days
    start = DateUtilities.startOfDay(today.subtract(Duration(days: 10)));
    end = DateUtilities.endOfDay(DateUtilities.previousDay(today));
    intervals.add(_buildInterval('10 Tage', allActivities, start, end));
    // this month
    start = DateUtilities.startOfMonth(today);
    end = DateUtilities.endOfMonth(today);
    intervals.add(_buildInterval('Diesen Monat', allActivities, start, end));
    // last month
    start = DateUtilities.startOfMonth(DateUtilities.previousDay(DateUtilities.startOfMonth(today)));
    end = DateUtilities.endOfMonth(start);
    intervals.add(_buildInterval('Letzten Monat', allActivities, start, end));
    // last 90 days
    start = DateUtilities.startOfDay(today.subtract(Duration(days: 90)));
    end = DateUtilities.endOfDay(DateUtilities.previousDay(today));
    intervals.add(_buildInterval('90 Tage', allActivities, start, end));
    // this year
    start = DateUtilities.startOfYear(today);
    end = DateUtilities.endOfYear(today);
    intervals.add(_buildInterval('Dieses Jahr', allActivities, start, end));
    // total all activities
    start = DateTime.fromMillisecondsSinceEpoch(0);
    end = DateUtilities.endOfDay(today);
    intervals.add(_buildInterval('Insgesamt', allActivities, start, end));

    return ReportingConfig(intervals: intervals);
  }

  ReportingInterval _buildInterval(String title, List<Activity> allActivities, DateTime start, DateTime end) {
    double distance = 0.0;
    int duration = 0;
    List<Activity> activities = allActivities.where((d) => DateUtilities.isBetween(d.time, start, end)).toList();
    activities.forEach((e) {
      distance += e.distance;
      duration += e.duration;
    });
    return ReportingInterval(
      title: title,
      start: start,
      end: end,
      activities: activities,
      distance: distance,
      duration: duration,
    );
  }
}
