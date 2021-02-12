import 'package:woas/app/utilities/date_utilities.dart';

void main() {
    // start and and of day
    final today = DateTime.now();
    print('start of day: ${DateUtilities.startOfDay(today)}');
    print('end of day: ${DateUtilities.endOfDay(today)}');
    print('next day: ${DateUtilities.nextDay(today)}');
    print('start of week: ${DateUtilities.startOfWeek(today)}');
    print('end of week: ${DateUtilities.endOfWeek(today)}');
    print('start of month: ${DateUtilities.startOfMonth(today)}');
    print('end of month: ${DateUtilities.endOfMonth(today)}');
    print('start of year: ${DateUtilities.startOfYear(today)}');
    print('end of year: ${DateUtilities.endOfYear(today)}');

}
