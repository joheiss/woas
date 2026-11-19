import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:woas/app/widgets/basic_date_field.dart';
import 'package:woas/app/widgets/basic_time_field.dart';

// Regression: the date/time fields used flutter/material.dart widgets inside a
// material_ui Scaffold, which threw "No Material widget found" (grey screen).
void main() {
  final date = TextEditingController(text: '19.11.2026');
  final time = TextEditingController(text: '08:30');

  Future<void> pump(WidgetTester tester) => tester.pumpWidget(MaterialApp(
        locale: Locale('de', 'DE'),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [Locale('en'), Locale('de', 'DE')],
        home: Scaffold(
          body: Column(children: [
            BasicDateField(controller: date),
            BasicTimeField(controller: time),
          ]),
        ),
      ));

  testWidgets('fields build inside the app shell', (tester) async {
    await pump(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('date picker opens and takes the selection', (tester) async {
    await pump(tester);
    await tester.tap(find.byType(BasicDateField));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(date.text, '19.11.2026');
  });

  testWidgets('time picker opens', (tester) async {
    await pump(tester);
    await tester.tap(find.byType(BasicTimeField));
    await tester.pumpAndSettle();
    expect(find.byType(TimePickerDialog), findsOneWidget);
  });
}
