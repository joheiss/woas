import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await setupLocator();
    runApp(App());
  } catch (e) {
    print(e);
  }
}


