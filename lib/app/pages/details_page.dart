import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woas/app/models/activity.dart';
import 'package:woas/app/models/reporting_interval.dart';

import 'new_page.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({this.interval});

  final ReportingInterval interval;

  final nf = NumberFormat('##0.0#', 'de_DE');

  static final String route = 'details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meine Aktivitäten'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: interval.activities.length,
            itemBuilder: (BuildContext context, int index) {
              Activity activity = interval.activities[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff212121),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(context, NewPage.route, arguments: activity),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    leading: Text(
                      '${DateFormat('dd.MM.yyyy').format(activity.time)}',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    title: Text('${activity.route}'),
                    subtitle: Text('${activity.duration} min'),
                    trailing: Text(
                      '${nf.format(activity.distance)} km',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
