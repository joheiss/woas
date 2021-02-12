import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/chart_tile.dart';
import '../widgets/overview_tile.dart';
import '../models/activity.dart';
import '../../service_locator.dart';
import '../services/firebase_service.dart';
import '../services/reporting_service.dart';
import 'new_page.dart';

class DashBoardPage extends StatelessWidget {
  static final String route = 'dashboard';
  final _firebaseService = locator<FirebaseService>();
  final _reportingService = locator<ReportingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meine Aktivitäten'),
        centerTitle: true,
      ),
      drawer: MenuDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService.fetchAllActivities(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Center(child: Text('Keine Daten gefunden'));
              final allActivities = snapshot.data.docs.map((d) => Activity.fromFS(d.id, d.data())).toList();
              // allActivities.forEach((a) => print('(TRACE) activity: ${a.id}, ${a.uid}, ${a.time.toString()}, ${a.distance}'));
              final config = _reportingService.buildIntervals(allActivities);
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    children: [
                      OverviewTile(interval: config.intervals[0]),
                      SizedBox(width: 10.0),
                      OverviewTile(interval: config.intervals[1]),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  ChartTile(interval: config.intervals[2]),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      OverviewTile(interval: config.intervals[3]),
                      SizedBox(width: 10.0),
                      OverviewTile(interval: config.intervals[4]),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      OverviewTile(interval: config.intervals[5]),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      OverviewTile(interval: config.intervals[6]),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      OverviewTile(interval: config.intervals[7]),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewPage.route, arguments: Activity.fromEmpty()),
        child: Icon(Icons.add),
      ),
    );
  }
}
