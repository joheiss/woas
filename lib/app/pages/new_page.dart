import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/activity.dart';
import '../services/firebase_service.dart';
import '../../service_locator.dart';
import '../widgets/basic_date_field.dart';
import '../widgets/basic_time_field.dart';

class NewPage extends StatefulWidget {
  NewPage({required this.activity});
  final Activity activity;

  static final String route = 'new';

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final _firebaseService = locator<FirebaseService>();
  late TextEditingController dateEditController;
  late TextEditingController timeEditController;
  late TextEditingController routeEditController;
  late TextEditingController distanceEditController;
  late TextEditingController durationEditController;
  late TextEditingController weightEditController;

  @override
  void initState() {
    super.initState();
    final nf = NumberFormat('##0.0#', 'de_DE');
    print('(TRACE) Activity: ${widget.activity}');
    dateEditController = TextEditingController(text: DateFormat('dd.MM.yyyy').format(widget.activity.time!));
    timeEditController = TextEditingController(text: DateFormat('HH:mm').format(widget.activity.time!));
    routeEditController = TextEditingController(text: widget.activity.route);
    distanceEditController = TextEditingController(text: widget.activity.distance != null ? nf.format(widget.activity.distance) : null);
    durationEditController = TextEditingController(text: widget.activity.duration != null ? widget.activity.duration.toString() : null);
    weightEditController = TextEditingController(text: widget.activity.weight != null ? widget.activity.weight.toString() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neue Aktivität'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BasicDateField(
                  controller: dateEditController,
                ),
                SizedBox(height: 10.0),
                BasicTimeField(
                  controller: timeEditController,
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: routeEditController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Strecke',
                    prefixIcon: Icon(Icons.directions_run_rounded),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: distanceEditController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Distanz',
                    prefixIcon: Icon(Icons.straighten),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: durationEditController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Dauer',
                    prefixIcon: Icon(Icons.timer),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: weightEditController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Gewicht',
                    prefixIcon: Icon(Icons.fitness_center),
                  ),
                ),
                SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: () {
                    print('(TRACE) Activity id: ${widget.activity.id}');
                    if (widget.activity.id == null) _createActivity();
                    else _updateActivity();
                    Navigator.pop(context);
                  },
                  // color: Theme.of(context).accentColor,
                  // elevation: 5.0,
                  child: Text('Speichern'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createActivity() async {
    final activity = Activity(
      time: _dateTimeFromStrings(dateEditController.value.text, timeEditController.value.text),
      route: routeEditController.value.text,
      distance: double.parse(distanceEditController.value.text.replaceFirst(',', '.')),
      duration: int.parse(durationEditController.value.text),
      weight: int.tryParse(weightEditController.value.text),
    );
    await _firebaseService.addActivity(activity);
  }

  void _updateActivity() async {
    widget.activity.time = _dateTimeFromStrings(dateEditController.value.text, timeEditController.value.text);
    widget.activity.route = routeEditController.value.text;
    widget.activity.distance = double.parse(distanceEditController.value.text.replaceFirst(',', '.'));
    widget.activity.duration = int.parse(durationEditController.value.text);
    widget.activity.weight = int.tryParse(weightEditController.value.text);
    await _firebaseService.updateActivity(widget.activity);
  }
  DateTime _dateTimeFromStrings(String date, String time) {
    int year = int.parse(date.substring(6,10));
    int month = int.parse(date.substring(3,5));
    int day = int.parse(date.substring(0,2));
    int hour = int.parse(time.substring(0,2));
    int minute = int.parse(time.substring(3,5));
    return DateTime(year, month, day, hour, minute);
  }
}

