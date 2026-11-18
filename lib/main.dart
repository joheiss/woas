import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'service_locator.dart';

import 'app/app.dart';

/// Loads the Firebase credentials from lib/google-services.json (git-ignored).
/// See lib/google-services.example.json for the expected format.
Future<FirebaseOptions> _loadFirebaseOptions() async {
  final raw = await rootBundle.loadString('lib/google-services.json');
  final json = jsonDecode(raw) as Map<String, dynamic>;
  return FirebaseOptions(
    apiKey: json['apiKey'] as String,
    appId: json['appId'] as String,
    messagingSenderId: json['messagingSenderId'] as String,
    projectId: json['projectId'] as String,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: await _loadFirebaseOptions());
    // runApp(MyApp());
    // await Firebase.initializeApp();
    await setupLocator();
    runApp(App());
  } catch (e) {
    print(e);
  }
}


