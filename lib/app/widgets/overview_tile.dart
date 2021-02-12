import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woas/app/models/activity.dart';
import 'package:woas/app/pages/new_page.dart';
import '../models/reporting_interval.dart';
import '../pages/details_page.dart';

class OverviewTile extends StatelessWidget {
  final ReportingInterval interval;
  OverviewTile({this.interval});

  final nf = NumberFormat('##0.0#', 'de_DE');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (interval.title == 'Heute') {
            Activity activity;
            if (interval.activities.length == 0) {
              activity = Activity.fromEmpty();
            } else {
              activity = interval.activities[0];
            }
            Navigator.pushNamed(context, NewPage.route, arguments: activity);
          } else {
            Navigator.pushNamed(context, DetailsPage.route, arguments: interval);
          }
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              color: Color(0xff212121),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  interval.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${interval.distance >= 0 ? nf.format(interval.distance) : nf.format(0.0)}',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                    Text(
                      ' km',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${interval.duration.toString()}',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      ' min',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
