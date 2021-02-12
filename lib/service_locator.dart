import 'package:get_it/get_it.dart';
import 'app/services/reporting_service.dart';
import 'app/services/firebase_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<FirebaseService>(FirebaseService());
  locator.registerSingleton<ReportingService>(ReportingService());

}


