import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:woas/app/models/reporting_interval.dart';
import 'package:woas/app/pages/details_page.dart';
import 'package:woas/app/widgets/chart_tile.dart';

void main() {
  testWidgets('tapping the chart area navigates to the details page', (tester) async {
    final interval = ReportingInterval(title: '10 Tage', activities: []);
    String? pushed;
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (s) {
        if (s.name == '/') {
          return MaterialPageRoute(builder: (_) => Scaffold(body: ChartTile(interval: interval)));
        }
        pushed = s.name;
        return MaterialPageRoute(builder: (_) => Scaffold(body: Text('details')));
      },
    ));
    await tester.tap(find.byType(BarChart), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(pushed, DetailsPage.route);
  });
}
