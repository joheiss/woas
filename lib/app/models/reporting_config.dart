import 'reporting_interval.dart';

class ReportingConfig {
  List<String>? routes;
  List<ReportingInterval>? intervals;
  ReportingConfig({this.intervals, this.routes});
}
