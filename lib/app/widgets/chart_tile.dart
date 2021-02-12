import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../pages/details_page.dart';
import '../models/reporting_interval.dart';

class ChartTile extends StatelessWidget {
  ChartTile({this.interval});

  final ReportingInterval interval;

  @override
  Widget build(BuildContext context) {
    print('(TRACE) # of activities ${interval.activities.length}');
    return GestureDetector(
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
                '10 Tage',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: BarChart(
                  _getData(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartData _getData(context) {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 8,
          getTitles: (double value) => value.toStringAsFixed(0),
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 12,
          getTitles: (double value) {
            return value.toStringAsFixed(1);
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _buildGroups(context),
    );
  }

  List<BarChartGroupData> _buildGroups(BuildContext context) {
    List<BarChartGroupData> data = <BarChartGroupData>[];
    for (int i = 0; i < 10; i++) {
      final date = DateTime.now().subtract(Duration(days: 10 - i));
      data.add(BarChartGroupData(
        x: date.day,
        barRods: [
          BarChartRodData(
            y: _getDistanceForDate(date),
            colors: [Theme.of(context).accentColor],
          ),
        ],
      ));
    }
    return data;
  }

  double _getDistanceForDate(DateTime date) {
    final activity = interval.activities.firstWhere((a) => a.time.day == date.day, orElse: () => null);
    if (activity == null) return 0.0;
    print('(TRACE) Activity found: ${activity.id}, ${activity.time.toIso8601String()}, ${activity.distance}');
    return activity.distance;
  }
}
