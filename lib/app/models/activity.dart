import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String uid;
  DateTime time;
  String route;
  double distance;
  int duration;
  int weight;

  Activity({this.id, this.uid, this.time, this.route, this.distance, this.duration, this.weight});

  Activity.fromEmpty() {
    this.time = DateTime.now();
    this.route = 'Crosstrainer';
  }

  Activity.fromFS(String id, Map<String, dynamic> fields) {
    this.id = id;
    uid = fields['uid'];
    time = DateTime.fromMillisecondsSinceEpoch(fields['time'].millisecondsSinceEpoch);
    route = fields['route'];
    distance = fields['distance'];
    duration = fields['duration'];
    weight = fields['weight'];
  }
}