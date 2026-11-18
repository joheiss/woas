
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String? id;
  String? uid;
  DateTime? time;
  String? route;
  double? distance;
  int? duration;
  int? weight;

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
    distance = (fields['distance'] as num?)?.toDouble();
    duration = (fields['duration'] as num?)?.toInt();
    weight = (fields['weight'] as num?)?.toInt();
  }

  Activity.fromFSNew(String id, DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final fields = snapshot.data();
    this.id = id;
    uid = fields?['uid'];
    time = DateTime.fromMillisecondsSinceEpoch(
        fields?['time'].millisecondsSinceEpoch);
    route = fields?['route'];
    distance = (fields?['distance'] as num?)?.toDouble();
    duration = (fields?['duration'] as num?)?.toInt();
    weight = (fields?['weight'] as num?)?.toInt();
  }
}