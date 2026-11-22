import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:woas/app/models/activity.dart';
import '../pages/details_page.dart';
import '../models/reporting_interval.dart';
import '../utilities/date_utilities.dart';

/// The value summed up per day in a [ChartTile].
enum ChartMetric { distance, duration }

class ChartTile extends StatelessWidget {
  ChartTile({required this.interval, this.metric = ChartMetric.distance});

  final ReportingInterval interval;
  final ChartMetric metric;

  String get _title => metric == ChartMetric.distance ? '10 Tage · km' : '10 Tage · min';

  /// Sums [metric] of all [activities] per calendar day (CET/CEST).
  /// Returns one total per entry in [days], in the same order.
  static List<double> dailyTotals(List<Activity> activities, List<DateTime> days, ChartMetric metric) {
    final totals = <DateTime, double>{};
    for (final a in activities) {
      if (a.time == null) continue;
      final day = DateUtilities.berlinDate(a.time!);
      final value = metric == ChartMetric.distance ? (a.distance ?? 0.0) : (a.duration ?? 0).toDouble();
      totals[day] = (totals[day] ?? 0.0) + value;
    }
    return days.map((d) => totals[DateTime(d.year, d.month, d.day)] ?? 0.0).toList();
  }

  /// The 10 days before today (CET/CEST), oldest first.
  static List<DateTime> lastTenDays() {
    final today = DateUtilities.berlinDate(DateTime.now());
    return List.generate(10, (i) => DateTime(today.year, today.month, today.day - (10 - i)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pushNamed(context, DetailsPage.route, arguments: interval),
      child: AspectRatio(
        aspectRatio: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: Color(0xff212121),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Expanded(
                // The chart is display-only; ignore its own touch handling so
                // taps reach the tile's GestureDetector.
                child: IgnorePointer(
                  child: BarChart(
                    _getDataNew(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _axisStyle = TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 12);

  Widget _axisLabel(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      child: Text(meta.formattedValue, style: _axisStyle),
    );
  }

  BarChartData _getDataNew(context) {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            getTitlesWidget: _axisLabel,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 48,
            getTitlesWidget: _axisLabel,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: _buildGroups(context),
    );
  }

  List<BarChartGroupData> _buildGroups(BuildContext context) {
    final days = lastTenDays();
    final totals = dailyTotals(interval.activities, days, metric);
    return List.generate(days.length, (i) => BarChartGroupData(
          x: days[i].day,
          barRods: [
            BarChartRodData(
              toY: totals[i],
              color: Colors.tealAccent,
            ),
          ],
        ));
  }
}
