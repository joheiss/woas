import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/activity.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> login(String email, String password) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (creds.user != null)
        return creds.user;
      else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logoff() {
    return _auth.signOut();
  }

  Future<DocumentReference> addActivity(Activity activity) {
    return _store.collection('activities').add({
      'uid': _auth.currentUser!.uid,
      'route': activity.route,
      'time': Timestamp.fromMillisecondsSinceEpoch(activity.time!.millisecondsSinceEpoch),
      'distance': activity.distance,
      'duration': activity.duration,
      'weight': activity.weight,
    });
  }

  Stream<QuerySnapshot> fetchAllActivities() {
    return _store
        .collection('activities')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .orderBy('time', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchActivitiesByTime(DateTime start, DateTime end) {
    final from = Timestamp.fromMillisecondsSinceEpoch(start.millisecondsSinceEpoch);
    final to = Timestamp.fromMillisecondsSinceEpoch(end.millisecondsSinceEpoch);
    return _store
        .collection('activities')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .where('time', isGreaterThanOrEqualTo: from)
        .where('time', isLessThanOrEqualTo: to)
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<void> updateActivity(Activity activity) {
    return _store.collection('activities').doc(activity.id).get().then((doc) {
      if (!doc.exists) return null;
      return doc.reference.update({
        'time': activity.time,
        'route': activity.route,
        'distance': activity.distance,
        'duration': activity.duration,
        'weight': activity.weight,
      });
    });
  }
}
