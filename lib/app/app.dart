import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/activity.dart';
import 'models/reporting_interval.dart';
import 'services/firebase_service.dart';
import '../service_locator.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/details_page.dart';
import 'pages/new_page.dart';

class App extends StatelessWidget {
  final _firebaseService = locator<FirebaseService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      locale: Locale('de', 'DE'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('de', 'DE'),
      ],
      onGenerateRoute: _generateRoute,
    );
  }

  Route<Widget> _generateRoute(RouteSettings settings) {

    final uid = _firebaseService.getCurrentUser();
    if (uid == null || settings.name == LoginPage.route) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginPage();
        }
      );
    }
    if (settings.name == DetailsPage.route) {
      return MaterialPageRoute(
          builder: (BuildContext context) {
            final interval = settings.arguments as ReportingInterval;
            return DetailsPage(interval: interval);
          }
      );
    }
    if (settings.name == NewPage.route) {
      return MaterialPageRoute(
          builder: (BuildContext context) {
            final activity = settings.arguments as Activity;
            return NewPage(activity: activity);
          }
      );
    }
    return MaterialPageRoute(
        builder: (BuildContext context) {
          return DashBoardPage();
        }
    );
  }
}
