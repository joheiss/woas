import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:woas/app/models/activity.dart';
import 'package:woas/app/pages/new_page.dart';
import 'package:woas/app/services/firebase_service.dart';
import 'package:woas/service_locator.dart';

class _FakeFirebase implements FirebaseService {
  @override
  dynamic noSuchMethod(Invocation i) => null;
}

void main() {
  setUp(() async {
    await locator.reset();
    locator.registerSingleton<FirebaseService>(_FakeFirebase());
  });

  testWidgets('NewPage builds for a new activity (app theme and locale)', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData.dark().copyWith(),
      locale: Locale('de', 'DE'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale('en'), Locale('de', 'DE')],
      home: NewPage(activity: Activity.fromEmpty()),
    ));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Neue Aktivität'), findsOneWidget);
  });
}
