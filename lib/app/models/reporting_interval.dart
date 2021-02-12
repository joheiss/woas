import 'activity.dart';

enum ReportingIntervalSize {
  week,
  month,
  year,
}

class ReportingInterval {
  final String title;
  final DateTime start;
  final DateTime end;
  List<Activity> activities;
  double distance;
  int duration;
  int weight;

  ReportingInterval({this.title, this.start, this.end, this.activities = const<Activity>[], this.distance = 0.0, this.duration = 0, this.weight = 0});
}